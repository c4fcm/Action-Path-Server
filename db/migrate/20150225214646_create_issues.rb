class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :status
      t.string :summary
      t.string :description
      t.decimal :lat
      t.decimal :lng
      t.text :address
      t.string :image_full

      t.timestamps null: false
    end
  end
end
