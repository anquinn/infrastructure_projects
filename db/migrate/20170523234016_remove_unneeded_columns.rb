class RemoveUnneededColumns < ActiveRecord::Migration
  def change
  	remove_column :projects, :location_en
  	remove_column :projects, :location_fr
  	remove_column :projects, :region
  	remove_column :programs, :project_id
  	remove_column :categories, :project_id
  end
end
