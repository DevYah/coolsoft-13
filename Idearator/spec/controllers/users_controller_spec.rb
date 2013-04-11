require 'rspec-helper'

describe UsersController do 

	describe "approve-committee" do
		a = Admin.new
		a.email = 'admin@gmail.com'
		a.password = '123123123'
		a.username = 'admin'
		a.confirm!
		a.save
		c = Comittee.new
		c.email = 'mohammad28march1993@gmail.com'
		c.password = '123123123'
		c.username = 'c'
		c.confirm!
		c.save
		it 'it sets the approved value of committee to approved'
		put :approve_committee, :id => c.id
		c.reload
		expect(c.approved).to eq(true)
		it 'redirects to admins index page'
		response.should redirect_to("admins/index")
	end

	describe "reject_committee" do
			a = Admin.new
		a.email = 'admin@gmail.com'
		a.password = '123123123'
		a.username = 'admin'
		a.confirm!
		a.save
		c = Comittee.new
		c.email = 'mohammad28march1993@gmail.com'
		c.password = '123123123'
		c.username = 'c'
		c.confirm!
		c.save
		it 'it sets the type of user to nil hence revoking his status as Comittee'
		put :reject_committee, :id => c.id
		c.reload
		expect(c.type).to eq(nil)
		it 'redirects to admins index page'
		response.should redirect_to("admins/index")
	end
end