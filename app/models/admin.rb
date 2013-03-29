class Admin < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :inviteds
end
