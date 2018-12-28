class CreateStatusChanges < ActiveRecord::Migration[4.2]
  def change
    create_table :status_changes do |t|
      t.references :ticket, index: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
