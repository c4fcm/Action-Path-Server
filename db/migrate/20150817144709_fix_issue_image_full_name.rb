class FixIssueImageFullName < ActiveRecord::Migration
  def change
    rename_column :issues, :image_full, :scf_image_url
  end
end
