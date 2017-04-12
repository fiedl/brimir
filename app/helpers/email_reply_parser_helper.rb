module EmailReplyParserHelper

  def parse_email_reply(ticket_or_reply)
    content = if ticket_or_reply.text_content && (not ticket_or_reply.text_content.include?("<p>"))
      if ticket_or_reply.kind_of? Ticket
        pre_and_wrap ticket_or_reply.text_content
      elsif ticket_or_reply.kind_of? Reply
        pre_and_wrap email_reply_parser ticket_or_reply.text_content
      end
    elsif ticket_or_reply.content_type == 'text'
      if ticket_or_reply.kind_of? Ticket
        pre_and_wrap ticket_or_reply.content
      elsif ticket_or_reply.kind_of? Reply
        pre_and_wrap email_reply_parser ticket_or_reply.content
      end
    elsif ticket_or_reply.content_type == 'html'
      sanitize_html email_reply_parser(ticket_or_reply.content), ticket_or_reply.inline_files
    else
      raise 'Case not handled, yet.'
    end
    content = content.gsub("\xC2\xA0", " ").html_safe # remove nbsp, which auto_link can't handle.
    content = auto_link content
  end

  def pre_and_wrap(text)
    #content_tag :pre do
    #  word_wrap text, line_width: 72
    #end
    simple_format text
  end

  def email_reply_parser(text)
    ExtendedEmailReplyParser.parse text
  end

end