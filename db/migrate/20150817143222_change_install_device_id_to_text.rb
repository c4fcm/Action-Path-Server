class ChangeInstallDeviceIdToText < ActiveRecord::Migration
  def up
    change_column :installs, :device_id, :text
  end
  def down
    # This might cause trouble if you have strings longer than 255 characters.
    change_column :installs, :device_id, :string
  end
end
