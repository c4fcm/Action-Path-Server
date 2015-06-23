class AddInstallIdToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :install_id, :string
  end
end
