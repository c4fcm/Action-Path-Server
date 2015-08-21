class AddLatLngToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :lat, :float
    add_column :responses, :lng, :float
  end
end
