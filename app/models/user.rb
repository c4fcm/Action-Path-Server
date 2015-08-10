class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :installs
  has_many :issues, through: :subscriptions
  
end
