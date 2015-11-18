class AddIsRealToInstalls < ActiveRecord::Migration
  def change
    add_column :installs, :is_real, :boolean, default: false
  end
end
