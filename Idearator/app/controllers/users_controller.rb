class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @ideas = Idea.find(:all, :conditions => { :user_id => @user.id })

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
  	end
  end 

end
