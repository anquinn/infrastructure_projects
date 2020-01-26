class AddRegionToLocation < ActiveRecord::Migration
  def change
    add_reference :locations, :region, index: true, foreign_key: true
  end
end
