# This rake task loops through all tickets and replies
# and fills the `text_content` column if `nil` with the
# text content read from the raw email files.
#
# This uses the ExtendedEmailReplyParser,
# https://github.com/fiedl/extended_email_reply_parser
#
task :fill_text_content_from_email_files => [:environment] do

  (Ticket.all + Reply.all).each do |ticket_or_reply|
    ticket_or_reply.import_text_content_from_raw_message
    print "."
  end
  print "\n"

end