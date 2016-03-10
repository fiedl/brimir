# Brimir is a helpdesk system to handle email support requests.
# Copyright (C) 2012-2015 Ivaldi https://ivaldi.nl/
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# tracks which user was notified for a notifiable object
class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  # Track the delivery type:
  #   (a) The recipient is specified in the `To` field.
  #   (b) The recipient is specified in the `CC` field.
  #   (c) The recipient is specified in the `BCC` field.
  #   (d) The recipient is notified by the ticket system only: If a client creates
  #       a new ticket via email, he does not include the agent direclty in any of
  #       the `To`, `CC`, or `BCC` fields. The agent is just notified by the ticket
  #       system.
  #
  enum delivery_type: {to: nil, cc: 1, bcc: 2, agent_notification: 3}
  scope :to, -> { where('delivery_type IS NULL') }
  
  # Track the state of the delivery.
  #   (a) The notification has been delivered somehow. This is the default
  #       since we can't determine the state of notifications before that code change.
  #   (b) The notification is due to deliver. Only messages that are `due` will be
  #       sent by brimir.
  #   (c) The notification has been delivered by brimir.
  #   (d) The notification has been delivered by the sender email server.
  #       If the client sends an email `To support@example.com, CC foo@example.com`
  #       then the recipient foo@example.com has already been notified by the sender
  #       server and does not need to be notified by brimir.
  #
  enum state: {delivered: nil, due: 1, delivered_by_brimir: 2, delivered_by_external_sender: 3}
  scope :delivered, -> { where('state IS NULL OR state = ? OR state = ?', 2, 3) }

  def self.from_mail_message(message)
    (message.to || []).collect { |email| User.where(email: email).first_or_create.notifications.to.build } +
    (message.cc || []).collect { |email| User.where(email: email).first_or_create.notifications.cc.build }
  end
  
  def self.users
    User.find self.pluck(:user_id)
  end
end
