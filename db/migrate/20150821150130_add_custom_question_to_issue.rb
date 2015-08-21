class AddCustomQuestionToIssue < ActiveRecord::Migration
  def change
  	add_column :issues, :question, :text
  	add_column :issues, :answer1, :text
  	add_column :issues, :answer2, :text
  	add_column :issues, :answer3, :text
  	add_column :issues, :answer4, :text
  	add_column :issues, :answer5, :text
  	add_column :issues, :answer6, :text
  end
end
