class Invited < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :email, :admin_id
  validates :email ,  
            :presence => true,   
            :uniqueness => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :admin_id,  :presence => true   
  belongs_to :admins
<<<<<<< HEAD

##
# creates invitated object and stores 
# the invitation in the database if it is valid
=======
# checks the validations and creates new +Invited+ object 
# Params:
>>>>>>> 60a31f0b7c12323f9c4a133acb6d77a0808ea874
# +email+:: the email of the  guest
# +admin_id+:: the id of the admin making the invitation
# Author: muhammed hassan
  def self.creates(mail ,id)
    i = Invited.new(:email=> mail , :admin_id => id)
    if i.valid?
      i.save
    end
    return i
  end
end
