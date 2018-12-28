class AddContentTypeToReplies < ActiveRecord::Migration[4.2]
  def change
    add_column :replies, :content_type, :text
    add_column :tickets, :content_type, :text
  end
end
