class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :record_count, default: 0

      t.timestamps null: false
    end
  end
end
