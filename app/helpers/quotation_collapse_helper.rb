# This helper handles the collapse of quotations in replies.
# In conversation views, several replies are shown in one view or email.
# Therefore the quotations (blockquotes) of old replies should not be shown.
# 
# Previously, those quotations have been filtered out at the model level.
# But, what if the system removes an inteded inline quote?
#
# Therefore, this helper hides quotations but does not remove them.
# The user can show the quotations by clicking a plus icon,
# in tickets#show as well as in emails.
#
module QuotationCollapseHelper
  
  # Insert divs and css such that quotations in the given `content` are
  # collapsed, i.e. hidden until the user clicks a plus icon.
  #
  def handle_quotation_collapse(content)
    result = content

    # 1. Remove custom style from email.
    #
    result = result
      .gsub(/<style.*<\/style>/im, "")
      .gsub(/<head.*<\/head>/im, "")
      .gsub(/&lt;!--[^<>]*--&gt;/im, "")

    # 2. Detect common ways that lead in email quotes or signatures.
    #    http://stackoverflow.com/a/2193937/2066546
    #
    result = collapse_regex(/-----Original Message-----.*/im, result)
    result = collapse_regex(/Sent from my iPhone*/im, result)
    result = collapse_regex(/Sent from my BlackBerry*/im, result)
    result = collapse_regex(/________________________________*/im, result)
    result = collapse_regex(/<blockquote.*<\/blockquote>/im, result)
    
    # 3. Detect phrases that are stored in the i18n definitions
    #    like "On September 09, 2015 08:24, foo@example.com wrote:"
    #
    I18n.available_locales.each do |locale|
      if (regex = I18n.translate(:on_date_author_wrote_regex, locale: locale)).present?
        # The `regex` is, for example, 'On .*wrote:.*'.
        #
        # If the regex is surrounded by `<div></div>`, we need to include
        # the opening `<div>`. Otherwise, the closing `</div>` would close
        # the collapse.
        #
        # If there is no `<div>`, the [^a-zA-Z0-9] part makes sure, 
        # the expression does not start within another word.
        #
        result = collapse_regex(/()((<div>)(#{regex}))()/im, result)
        result = collapse_regex(/([^a-zA-Z0-9])(#{regex})()/im, result)
      end
    end

    # 4. Detect our own conversation emails.
    #
    result = collapse_regex(/<div style="font-family: Helvetica; background-color: [^\s]*;">.*/im, result)
    
    return result
  end
  
  def collapse_regex(regex, content)
    if content.include?("collapsed-quote-content")
      content
    else
      content.gsub(regex) do |whole_quotation|
        if Regexp.last_match && Regexp.last_match[2]
          content_before_quote = Regexp.last_match[1]
          quote = Regexp.last_match[2]
          content_after_quote = Regexp.last_match[3] || ""
        else
          content_before_quote = ""
          quote = whole_quotation
          content_after_quote = ""
        end
        
        # The idea is to collapse via css in order to make it work
        # in emails as well.
        #
        # http://freshinbox.com/blog/hamburger-collapsible-menu-in-email/
        #
        content_before_quote +
        "<input id=\"#{new_checkbox_id}\" class=\"hidden-collapse-checkbox\" type=\"checkbox\">" +
        "<span>" +
        "  <label class=\"collapse-quote-toggle\" for=\"#{checkbox_id}\">[#{t(:toggle_collapsed_content)}]</label><br />" +
        "  <span class=\"collapsed-quote-content\">#{quote}</span>" +
        "</span>" +
        content_after_quote
      end
    end
  end
  
  private
  
  def new_checkbox_id
    $checkbox_id ||= 0
    $checkbox_id += 1
    $checkbox_id = 1 if $checkbox_id > 99999
    checkbox_id
  end
  
  def checkbox_id
    $checkbox_id ||= 0
    "hidden-collapse-checkbox-#{$checkbox_id}"
  end
  
end
