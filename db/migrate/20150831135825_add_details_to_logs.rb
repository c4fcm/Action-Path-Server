class AddDetailsToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :details, :string
  end
end
