class AddUserIssueToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :user_id, :integer
    add_column :subscriptions, :issue_id, :integer
  end
end
