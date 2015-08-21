class AddProviderToPlace < ActiveRecord::Migration
  def change
    add_column :places, :provider, :string, default: 'seeclickfix'
  end
end
