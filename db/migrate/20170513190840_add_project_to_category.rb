class AddProjectToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :project, index: true, foreign_key: true
  end
end
