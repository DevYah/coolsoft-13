class InvitedPerson < ActiveRecord::Base
  attr_accessible :admin, :committee, :email
  validates :email , :uniqueness => true
end
