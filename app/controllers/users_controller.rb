class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @ideas = @user.ideas
    @approved = @ideas.find(:all, :conditions => { :approved => true })
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    
  end
  end 


end

