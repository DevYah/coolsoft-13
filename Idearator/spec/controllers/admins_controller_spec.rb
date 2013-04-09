# spec/controllers/admins_controller_spec.rb 
require 'spec_helper'

describe AdminsController do 

   describe "invite_member" do 
   	it "retrieves the user instance from :id"
   	it "inititates the user to the committees table"
   	it "calls InviteCommitteeNotification.send_notification(Admin, User)"
   	it "redirects to admin's index page"
   end
end