class AdminsController < ApplicationController
  def show_users
    @users = User.all
  end
end
