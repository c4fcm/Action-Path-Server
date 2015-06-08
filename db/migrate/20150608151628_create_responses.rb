class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :issue_id
      t.datetime :timestamp
      t.string :answer

      t.timestamps null: false
    end
  end
end
