class AddTextContentToTickets < ActiveRecord::Migration[4.2]
  def change
    add_column :tickets, :text_content, :text, limit: (1.gigabyte - 1)
  end
end
