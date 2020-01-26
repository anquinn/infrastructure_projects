class AddCounterCaches < ActiveRecord::Migration
  def change
  	add_column :locations, :projects_count, :integer, default: 0, null: false

  	Location.find_each { |location| Location.reset_counters(location.id, :projects) }

  	add_column :programs, :projects_count, :integer, default: 0, null: false

  	Program.find_each { |program| Program.reset_counters(program.id, :projects) }

  	add_column :categories, :projects_count, :integer, default: 0, null: false

  	Category.find_each { |category| Category.reset_counters(category.id, :projects) }

  	add_column :regions, :projects_count, :integer, default: 0, null: false

  	Region.find_each { |region| Region.reset_counters(region.id, :projects) }
  end
end
