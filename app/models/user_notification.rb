class UserNotifications < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :users
  attr_accessible :link, :type, :user, :users 
end
