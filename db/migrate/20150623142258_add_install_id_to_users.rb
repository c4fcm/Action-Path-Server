class AddInstallIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :install_id, :string
  end
end
