class ChangeIntToDecimal < ActiveRecord::Migration
  def change
  	change_column :projects, :federal_contribution, :decimal, precision: 14, scale: 2
  	change_column :projects, :total_eligible_cost, :decimal, precision: 14, scale: 2
  end
end
