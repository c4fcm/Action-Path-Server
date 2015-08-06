class Install < ActiveRecord::Base
  self.primary_key = 'id'

  def self.get_or_create id
    matching_users = Install.where(:id=>id).count
    if matching_users==0
      found_user = Install.create(:id=>id) # this saves it too
    else
      found_user = Install.where(:id=>id).first
    end
    found_user
  end
  
end
