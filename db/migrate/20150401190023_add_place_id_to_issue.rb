class AddPlaceIdToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :place_id, :integer
  end
end
