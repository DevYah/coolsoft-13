class AdminsController < ApplicationController
before_filter :authenticate_user!
# toggles the ban status of the selected user
# Author: Omar Kassem
  def ban_unban
  	if current_user.type == 'Admin'
      @user=User.find(session[:user_id])
      @user.toggle(:banned)
      @user.save
    end  
  end  
end
