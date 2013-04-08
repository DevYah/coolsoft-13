class DashboardController < ApplicationController
  before_filter :authenticate_user!, :only => [:index]
  def index
    @user = current_user
    if @user.type == 'Committee'
      @approved_ideas = Idea.where(:committee_id => @user.id)
    end
    @own_ideas = Idea.where(:user_id => @user.id, :approved => true)
  end
end
