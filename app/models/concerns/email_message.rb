# Brimir is a helpdesk system to handle email support requests.
# Copyright (C) 2012-2016 Ivaldi https://ivaldi.nl/
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

module EmailMessage
  extend ActiveSupport::Concern

  included do
    has_many :attachments, as: :attachable, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_many :attached_files, -> { where(content_id: nil) }, as: :attachable, class_name: 'Attachment'

    has_attached_file :raw_message,
        path: Tenant.files_path

    do_not_validate_attachment_file_type :raw_message
  end

  def inline_files
    attachments.where.not(content_id: nil).map do |attachment|
      [attachment.content_id, attachment.file.url(:original)]
    end.to_h
  end

  def text_content
    super || import_text_content_from_raw_message
  end

  # This is needed because the text_content column has been created
  # later. For existing tickets and replies, the text_content is
  # extracted from the raw_message here.
  #
  def import_text_content_from_raw_message
    if original_raw_message? && file_name = original_raw_message.try(:path, :original)

      # Fix file path. It seems not all placeholders are replaced.
      # See also: Tenant#files_path
      #
      file_name.gsub!(":domain", Tenant.current_tenant.domain.to_s)

      if File.exists?(file_name) && File.file?(file_name)
        imported_text_content = ExtendedEmailReplyParser.extract_text file_name
        self.text_content ||= imported_text_content
        self.save
        return imported_text_content
      else
        return nil
      end
    end
  end

  # This is needed because the raw messages are not copied over correctly
  # when merging tickets.
  #
  def original_raw_message
    original_before_merge.try(:raw_message) || raw_message
  end
  def original_raw_message?
    (original_before_merge || self).raw_message_file_size.to_i > 0
  end
  def original_before_merge
    if self.kind_of? Reply
      Ticket.where(message_id: message_id).first || Reply.where(message_id: message_id).where.not(id: id).first
    else
      nil
    end
  end
end
