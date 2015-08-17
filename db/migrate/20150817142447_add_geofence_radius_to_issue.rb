class AddGeofenceRadiusToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :geofence_radius, :integer, default: 500
  end
end
