# spec/controllers/admins_controller_spec.rb
require 'spec_helper'

describe AdminsController do
  describe "approve_committee" do
    it "retrieves the user's instance"
    it "calls Inviter.committee_accept(email)"
    it "redirects to the admin's index page"
  end
  
  describe "reject_committee" do
    it "retrieves the user's instance"
    it "sets his type to nil"
    it "updates his database record"
    it "calls Inviter.committee_reject(email)"
    it "redirects to the admin's index page"
  end
  
  end
end