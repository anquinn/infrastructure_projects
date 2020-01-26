class AddProgramToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :program, index: true, foreign_key: true
  end
end
