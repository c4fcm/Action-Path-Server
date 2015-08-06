class AddDeviceIdToInstall < ActiveRecord::Migration
  def change
    add_column :installs, :device_id, :string
    remove_column :installs, :id
    add_column :installs, :id, :primary_key
  end
end
