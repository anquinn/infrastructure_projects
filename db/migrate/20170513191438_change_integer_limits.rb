class ChangeIntegerLimits < ActiveRecord::Migration
  def change
  	change_column :projects, :federal_contribution, :integer, limit: 8
  	change_column :projects, :total_eligible_cost, :integer, limit: 8
  end
end
