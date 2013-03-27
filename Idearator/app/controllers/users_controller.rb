class UsersController < ApplicationController
	before_filter :authenticate_user!, :only => [:expertise, :new_committee_tag]
	def expertise
		@user= current_user
		@tags= Tag.all
	end
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
