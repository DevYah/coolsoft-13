class UsersController < ApplicationController
	before_filter :authenticate_user!, :only => [:expertise, :new_committee_tag]
	#This method sends to the view all the tags available in the tag table
	#so they can be projected as checkboxes for the user 
	#to choose his area of expertise from them.
	#It also Sends the user_id "current_user" to be used in the form in the view.
	#Author: Mohamed Sameh
	def expertise
		@user= current_user
		@tags= Tag.all
	end
	#This method recieves all the checked tags from the view expertise in params,
	# and loops through all these tags and enters each one in the table committees_tags
	#it then redirects the user to the homepage. 
	#Author: Mohamed Sameh
	def new_committee_tag
		if params[:user] == nil
			respond_to do |format|
				format.html{
					flash[:notice] = 'You must choose at least 1 area of expertise'
					redirect_to action: 'expertise'
				}
			end
		else
			@tags= params[:user][:tags]
			@tags.each do |tag|
				CommitteesTags.create(:committee_id => current_user.id , :tag_id => tag)
			end
			respond_to do |format|
				format.html{
					redirect_to controller: 'home', action: 'index'
				}
			end
		end
	end
end
