class ChangeIssueLatLngToFloat < ActiveRecord::Migration
  def up
    change_column :issues, :lat, :float
    change_column :issues, :lng, :float
  end
  def down
    change_column :issues, :lat, :decimal
    change_column :issues, :lng, :decimal
  end
end
