class AdminsController < ApplicationController
# toggles the ban status of the selected user
# Author: Omar Kassem
  def ban_unban
    @user=User.find(session[:user_id])
    @user.toggle(:banned)
    @user.save
  end  
end
