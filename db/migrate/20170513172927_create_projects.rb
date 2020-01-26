class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :number
      t.string :title_en
      t.string :title_fr
      t.string :location_en
      t.string :location_fr
      t.string :region
      t.integer :federal_contribution
      t.integer :total_eligible_cost
      t.string :ultimate_recipient_en
      t.string :ultimate_recipient_fr
      t.date :forcasted_construction_start_date
      t.date :forcasted_construction_end_date
      t.date :approved_date
      t.date :construction_start_date
      t.date :construction_end_date

      t.timestamps null: false
    end
  end
end
