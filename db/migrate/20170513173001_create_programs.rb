class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title_en
      t.string :title_fr

      t.timestamps null: false
    end
  end
end
