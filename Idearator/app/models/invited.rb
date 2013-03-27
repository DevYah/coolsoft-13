class Invited < ActiveRecord::Base
  # attr_accessible :title, :body
<<<<<<< HEAD

  has_and_belongs_to_many :admins
=======
  attr_accessible :email, :admin_id
  belongs_to :admins
>>>>>>> C2_abuali_#46_invite_committee
end
