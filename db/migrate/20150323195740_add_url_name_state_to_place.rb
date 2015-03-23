class AddUrlNameStateToPlace < ActiveRecord::Migration
  def change
    add_column :places, :url_name, :string
    add_column :places, :state, :string
  end
end
