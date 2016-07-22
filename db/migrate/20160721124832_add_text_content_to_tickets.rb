class AddTextContentToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :text_content, :text, limit: (1.gigabyte - 1)
  end
end
