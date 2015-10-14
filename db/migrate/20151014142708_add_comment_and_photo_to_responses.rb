class AddCommentAndPhotoToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :comment, :text
    add_attachment :responses, :photo
  end
end
