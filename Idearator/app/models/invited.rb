class Invited < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :email, :admin_id
  validates :email ,  
            :presence => true,   
            :uniqueness => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :admin_id,  :presence => true   
  belongs_to :admins

  def self.creates(mail ,id)
    i = Invited.new(:email=> mail , :admin_id => id)
    if i.valid?
      i.save
    end
    return i
  end
end
