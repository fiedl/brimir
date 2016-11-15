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
    if raw_message? && file_name = raw_message.file_path

      if File.exists?(file_name) && File.file?(file_name) && Mail.read(file_name).content_type
        imported_text_content = ExtendedEmailReplyParser.extract_text(file_name)
        if self.read_attribute(:text_content).nil?
          self.update_column :text_content, imported_text_content
        end
        return imported_text_content
      else
        return nil
      end
    end
  end

end
