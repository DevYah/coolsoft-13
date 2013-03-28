class UsersController < ApplicationController

  #This method is used to generate the view of each User Profile. A specific user and his ideas are made
  #available to the view to presented in the appropriate manner.
  #Author: Hisham ElGezeery
  def show
    @user = User.find(params[:id])
    @ideas = Idea.find(:all, :conditions => { :user_id => @user.id })

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
  	end
  end 

end
