class CreateServiceHistoryEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :service_history_entries do |t|
      t.references :car, null: false, foreign_key: true
      t.string :service_type
      t.text :notes
      t.date :serviced_at
      t.integer :mileage

      t.timestamps
    end
  end
end
