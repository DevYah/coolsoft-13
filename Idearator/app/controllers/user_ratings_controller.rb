class UserRatingsController < ApplicationController
  before_filter :authenticate_user!

  # creates a new user rating
  # Params:
  # +idea_id+:: is the id of the instance of +Idea+ which it's perspective will be rated
  # +rating+:: is the new rating value that will be added to the +UserRating+ table
  # +rating_id+:: is the id of the instance of +Rating+, i.e Rating Perspective, which is being rated
  # Author: Mahmoud Abdelghany Hashish
  def create
    idea = Idea.find_by_id(params[:idea_id])
    user_rating = UserRating.new(params[:rating])
    user_rating.rating_id = params[:rating_id]
    user_rating.user_id = current_user.id
    
    if user_rating.save
      rating = Rating.find_by_id(params[:rating_id])
      saved_r = UserRating.find_by_rating_id(params[:rating_id])

      if saved_r.class != Array
        rating.value = user_rating.value.to_f
      else
        rating.value = ((saved_r.size * rating.value) + user_rating.value).to_f / (saved_r.size).to_f
      end

      rating.save
    else
      respond_to do |format|
        format.html { redirect_to idea, :notice => 'Your rating has not been saved, please retry!' }
        format.js
      end
    end
  end

  # updates an existing user rating
  # Params:
  # +idea_id+:: is the id of the instance of +Idea+ which it's perspective will be rated
  # +rating+:: is the new rating value that will be updated in the +UserRating+ table
  # +rating_id+:: is the id of the instance of +Rating+, i.e Rating Perspective, which is being rated
  # Author: Mahmoud Abdelghany Hashish
  def update
    idea = Idea.find_by_id(params[:idea_id])
    user_rating = current_user.user_ratings.find_by_rating_id(params[:rating_id])
    val = user_rating.value
    
    if user_rating.update_attributes(params[:rating])
      rating = Rating.find_by_id(params[:rating_id])
      saved_r = UserRating.find_by_rating_id(params[:rating_id])

      if saved_r.class != Array
        rating.value = user_rating.value.to_f
      else
        rating.value = ((saved_r.size * rating.value) - val + user_rating.value).to_f / (saved_r.size).to_f
      end

      rating.save
    else 
      respond_to do |format|
        format.html { redirect_to idea_path(idea), :notice => 'Your rating has not been updated, please retry!' }
        format.js 
      end
    end
  end
end