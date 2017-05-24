class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name_en
      t.string :name_fr

      t.timestamps null: false
    end
  end
end
