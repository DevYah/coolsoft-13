module UserRatingsHelper

  # passes either newely created or the existing user rating ballot to the user_ratings/_form.html.erb
  # Params:
  # +rating_id+:: is the id of the instance of +Rating+, i.e Rating Perspective, which is being rated
  def rating_ballot
    if @user_rating = current_user.user_ratings.find_by_rating_id(params[:rating_id])
        @User_rating
    else
        current_user.user_ratings.new
    end
  end

  # passes the existing user rating value, else string 'N/A', of a certain perspective to the user_ratings/_form.html.erb
  # Params:
  # +rating_id+:: is the id of the instance of +Rating+, i.e Rating Perspective, which is being rated
  def current_user_rating
    current_user = User.find(1)
    if @user_rating = current_user.user_ratings.find_by_rating_id(params[:rating_id])
        @user_rating.value
    else
        'N/A'
    end
  end
end