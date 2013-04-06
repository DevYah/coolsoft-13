class UserRatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @idea = Idea.find_by_id(params[:idea_id])
    @user_rating = UserRating.new(params[:user_rating])
    @user_rating.rating_id = params[:rating_id].id
    @user_rating.user_id = current_user.id
    if @user_rating.save
      respond_to do |format|
        format.html { redirect_to idea_path(@idea), :notice => 'Your rating has been saved' }
        format.js
      end
      respond_to do |format|
        format.html { redirect_to idea_path(@idea), :notice => 'Your rating has not been saved, please retry!' }
        format.js
      end
    end
  end

  def update
    @idea = Idea.find_by_id(params[:idea_id])
    @user_rating = current_user.user_ratings.find_by_rating_id(@rating.id)
    if @user_rating.update_attributes(params[:user_rating])
      respond_to do |format|
        format.html { redirect_to idea_path(@idea), :notice => 'Your rating has been updated' }
        format.js
      end
      respond_to do |format|
        format.html { redirect_to idea_path(@idea), :notice => 'Your rating has not been updated, please retry!' }
        format.js
      end
    end
  end
end