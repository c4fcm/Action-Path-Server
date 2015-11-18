class AddRequestTypeToInstalls < ActiveRecord::Migration
  def change
    add_column :installs, :request_type, :string
  end
end
