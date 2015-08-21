class RemoveUserFromLog < ActiveRecord::Migration
  def up
    remove_column :logs, :user_id
  end
  def down
    add_column :logs, :user_id, :integer
  end
end
