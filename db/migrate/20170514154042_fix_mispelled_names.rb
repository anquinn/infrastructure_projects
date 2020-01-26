class FixMispelledNames < ActiveRecord::Migration
  def change
  	rename_column :projects, :forcasted_construction_start_date, :forecasted_construction_start_date
  	rename_column :projects, :forcasted_construction_end_date, :forecasted_construction_end_date
  end
end
