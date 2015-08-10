class CreateInstalls < ActiveRecord::Migration
  def change
    create_table :installs do |t|
      t.integer :user_id
      t.timestamps null: false
    end
    change_column :installs, :id, :string
    remove_column :users, :install_id
    rename_column :responses, :user_id, :install_id
  end
end
