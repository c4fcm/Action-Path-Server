class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :issues, through: :subscriptions
end
