class Invited < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :email, :admin_id
  belongs_to :admins
end
