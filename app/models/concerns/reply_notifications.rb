concern :ReplyNotifications do
  
  include Notifiable
  
  # In order to determine the users to notify about a reply, there are several
  # cases to distinguish.
  #
  #   (a) The reply is sent by an agent.
  #       => The agent can send this reply via ui or via email. But he won't include the
  #          client's email addresses directly.
  #       => Send notifications to agents and clients.
  # 
  #   (b) The reply is sent by a client.
  #
  #       (b-1) If the client sends via incoming email, other clients are handled explicitly
  #             by the sender email server.
  #             => Send notifications only to agents.
  #
  #       (b-2) If the client sends via the ui, the ticket system is responsible for
  #             all deliveries.
  #             => Send notifications to agents and clients.
  #
  def set_default_notifications!(mail_message = nil)
    if self.user.agent?
      
    else
      if mail_message
        
      else
        
      end
    end
    
    
    if reply_to
      set_notifications_based_on_fomer_reply
    else
      set_notifications_based_on_agent_assignments
    end
  end
  
  def set_notifications_based_on_fomer_reply
    excluded_users = [user] + User.ticket_system_addresses
    
    # First guess: Answer to the person that wrote the former reply or ticket.
    # But the `to` field can't be empty. Second guess: Answer to the same people as before.
    self.notified_users_via_to = [reply_to.user] - excluded_users
    self.notified_users_via_to = reply_to.notified_users_via_to - excluded_users if self.notified_users_via_to.empty?

    self.notified_users_via_cc = reply_to.notified_users_via_to + reply_to.notified_users_via_cc - self.notified_users_via_to - excluded_users
    self.notified_users_via_bcc = reply_to.notified_users_via_bcc + reply_to.notified_users_via_agent_notification - self.notified_users_via_to - self.notified_users_via_cc - excluded_users
  end
  
  def set_notifications_based_on_agent_assignments
    result = []
    if ticket.assignee.present?
      result << ticket.assignee
    else
      result = User.agents_to_notify
    end

    ticket.labels.each do |label|
      result += label.users
    end

    self.notified_users_via_agent_notification = result.uniq
  end
  
  def set_notifications_based_on_mail_message(message)
    self.notifications << Notification.from_mail_message(message)
  end
  
end