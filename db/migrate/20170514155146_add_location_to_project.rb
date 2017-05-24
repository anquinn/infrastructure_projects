class AddLocationToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :location, index: true, foreign_key: true
  end
end
