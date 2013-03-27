class UsersController < ApplicationController

  #Description:Two variables are needed.A variable "user" to get the user for this particular profile,
  # ana a variable "ideas" that stores this user's ideas. The view accesses the attributes of both the two
  #variables and shows the information.
  #Author:Hisham ElGezeery
  def show
    @user = User.find(params[:id])
    @ideas = Idea.find(:all, :conditions => { :user_id => @user.id })

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
  	end
  end 

end
