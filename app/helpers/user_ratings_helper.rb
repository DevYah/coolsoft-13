module UserRatingsHelper
  def rating_ballot
    if @user_rating = current_user.user_ratings.find_by_rating_id(params[:rating_id])
        @User_rating
    else
        current_user.user_ratings.new
    end
  end

  def current_user_rating
    current_user = User.find(1)
    if @user_rating = current_user.user_ratings.find_by_rating_id(params[:rating_id])
        @user_rating.value
    else
        'N/A'
    end
  end
end