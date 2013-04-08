class AdminsController < ApplicationController
  def ban_unban
    @user=User.find(params[:id])
    @user.toggle(:banned)
end
