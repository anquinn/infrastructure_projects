class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title_en
      t.string :title_fr

      t.timestamps null: false
    end
  end
end
