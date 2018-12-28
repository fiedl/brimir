class KnowledgeBaseReply < StatusReply

  def self.create_from_label(ticket, label, current_user)
    message = I18n.t(:user_as_assigned_label, user: current_user.name, label: label.name, locale: ticket.user.locale)
    if template = EmailTemplate.find_by(name: label.name)
      message += "<p>" + template.message
      message += "<p>" + I18n.t(:has_this_resolved_your_issue)
    end
    reply = self.create_from_status_message(message, ticket, current_user)
    reply.notified_users = (reply.notified_users + [ticket.user] + [ticket.assignee] - [nil]).uniq
    return reply
  end

end
