class AddTextContentToReplies < ActiveRecord::Migration[4.2]
  def change
    add_column :replies, :text_content, :text, limit: (1.gigabyte - 1)
  end
end
