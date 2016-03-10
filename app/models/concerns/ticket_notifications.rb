concern :TicketNotifications do
  
  include Notifiable
  
  def set_default_notifications!
    users = User.agents_to_notify.select do |user|
      Ability.new(user).can? :show, self
    end
    self.notifications << users.collect { |user| user.notifications.agent_notification.build(notifiable: self) }
  end
  
end