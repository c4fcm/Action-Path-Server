class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :issues, through: :subscriptions
  
  def self.get_or_create_from_install_id install_id
    matching_users = User.where(:install_id=>install_id).count
    if matching_users==0
      found_user = User.create(:install_id=>install_id) # this saves it too
    else
      found_user = User.where(:install_id=>install_id).first
    end
    found_user
  end
  
end
