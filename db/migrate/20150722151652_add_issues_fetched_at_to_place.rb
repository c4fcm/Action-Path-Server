class AddIssuesFetchedAtToPlace < ActiveRecord::Migration
  def change
    add_column :places, :issues_fetched_at, :timestamp
  end
end
