concern :Notifiable do
  
  included do
    has_many :notifications, as: :notifiable, dependent: :destroy
    has_many :notifications_via_to, -> { to }, as: :notifiable, dependent: :destroy, class_name: 'Notification'
    has_many :notifications_via_cc, -> { cc }, as: :notifiable, dependent: :destroy, class_name: 'Notification'
    has_many :notifications_via_bcc, -> { bcc }, as: :notifiable, dependent: :destroy, class_name: 'Notification'
    has_many :notifications_via_agent_notification, -> { agent_notification }, as: :notifiable, dependent: :destroy, class_name: 'Notification'
  
    has_many :notified_users, source: :user, through: :notifications
    has_many :notified_users_via_to, source: :user, through: :notifications_via_to
    has_many :notified_users_via_cc, source: :user, through: :notifications_via_cc
    has_many :notified_users_via_bcc, source: :user, through: :notifications_via_bcc
    has_many :notified_users_via_agent_notification, source: :user, through: :notifications_via_agent_notification
  end
  
  def notified_agents
    notified_users.where(agent: true)
  end

end