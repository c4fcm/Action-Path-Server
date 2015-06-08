class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :type
      t.integer :user_id
      t.integer :issue_id
      t.string :action
      t.datetime :timestamp
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
