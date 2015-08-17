class AddAttachmentCustomImageToIssues < ActiveRecord::Migration
  def self.up
    change_table :issues do |t|
      t.attachment :custom_image
    end
  end

  def self.down
    remove_attachment :issues, :custom_image
  end
end
