
class AdminsController < ApplicationController
# toggles the ban status of the selected user
# Author: Omar Kassem
  def ban_unban
    if current_user  
      if current_user.type == 'Admin'
        @user=User.find(params[:id])
        @user.toggle(:banned)
        @user.save
        redirect_to :controller => 'users',:action => 'show' 
      end
    else
    respond_to do |format|
        format.html { redirect_to  '/' , notice: 'You cant ban/unban users' }
        format.json { head :no_content }
      end 
    end   
  end  
end
