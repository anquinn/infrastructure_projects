class AddProjectToProgram < ActiveRecord::Migration
  def change
    add_reference :programs, :project, index: true, foreign_key: true
  end
end
