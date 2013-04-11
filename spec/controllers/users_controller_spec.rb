require 'spec_helper'

describe UsersController do 
	include Devise::TestHelpers
	
	#Test for users#approve_committee
	#Author : Mohammad Abdulkhaliq
	describe "approve-committee" do
		before :each do
		  @a = Admin.new
			@a.email = 'admin@gmail.com'
			@a.password = '123123123'
			@a.username = 'admin'
			@a.confirm!
			@a.save
			@c = Committee.new
			@c.email = 'mohammad28march1993@gmail.com'
			@c.password = '123123123'
			@c.username = 'c'
			@c.confirm!
			@c.save
			sign_in @a
		end
		it 'it sets the approved value of committee to approved' do
			put :approve_committee, :id => @c.id
			@c.reload
			expect(@c.approved).to eq(true)
		end
		it 'redirects to admins index page' do
			put :approve_committee, :id => @c.id
			response.should redirect_to("/")
		end
	end
	
	#Test for users#reject_committee
	#Author : Mohammad Abdulkhaliq
	describe "reject_committee" do
		before :each do
			@a = Admin.new
			@a.email = 'admin@gmail.com'
			@a.password = '123123123'
			@a.username = 'admin'
			@a.confirm!
			@a.save
			@c = Committee.new
			@c.email = 'mohammad28march1993@gmail.com'
			@c.password = '123123123'
			@c.username = 'c'
			@c.confirm!
			@c.save
			sign_in @a
		end
		it 'it sets the type of user to nil hence revoking his status as Comittee' do
			tm = @c.id
			put :reject_committee, :id => @c.id
			expect(User.find(tm).type).to eq(nil)
		end
		it 'redirects to admins index page' do
			put :reject_committee, :id => @c.id
			response.should redirect_to("/")
		end
	end
end
