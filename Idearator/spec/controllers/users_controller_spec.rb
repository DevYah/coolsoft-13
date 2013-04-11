require 'spec_helper'

describe UsersController do 

	describe "approve-committee" do
		before :each do
			a = Admin.new
			a.email = 'admin@gmail.com'
			a.password = '123123123'
			a.username = 'admin'
			a.confirm!
			a.save
			c = Committee.new
			c.email = 'mohammad28march1993@gmail.com'
			c.password = '123123123'
			c.username = 'c'
			c.confirm!
			c.save
		end
		it 'it sets the approved value of committee to approved' do
			put :approve_committee, :id => c.id
			c.reload
			expect(c.approved).to eq(true)
		end
		it 'redirects to admins index page' do
			put :approve_committee, :id => c.id
			response.should redirect_to("admins/index")
		end
	end

	describe "reject_committee" do
		before :each do
			a = Admin.new
			a.email = 'admin@gmail.com'
			a.password = '123123123'
			a.username = 'admin'
			a.confirm!
			a.save
			c = Committee.new
			c.email = 'mohammad28march1993@gmail.com'
			c.password = '123123123'
			c.username = 'c'
			c.confirm!
			c.save
		end
		it 'it sets the type of user to nil hence revoking his status as Comittee' do
			put :reject_committee, :id => c.id
			c.reload
			expect(c.type).to eq(nil)
		end
		it 'redirects to admins index page' do
			put :reject_committee, :id => c.id
			response.should redirect_to("admins/index")
		end
	end
end
