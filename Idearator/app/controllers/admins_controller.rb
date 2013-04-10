
class AdminsController < ApplicationController
# toggles the ban status of the selected user
# Author: Omar Kassem
  def ban_unban
      @user=User.find(params[:id])
      @user.toggle(:banned)
      @user.save
     
  end  
end
