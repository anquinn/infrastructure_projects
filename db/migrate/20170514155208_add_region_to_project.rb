class AddRegionToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :region, index: true, foreign_key: true
  end
end
