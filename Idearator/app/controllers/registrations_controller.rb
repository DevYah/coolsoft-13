class RegistrationsController < Devise::RegistrationsController
  include OmniauthHandlerMixin

  # Allow the user to choose a different username if user's twitter screen name
  # is already used as a username locally
  #
  # Params:
  # +session['devise.twitter_data']+:: Saved twitter oauth data from login request
  # +params[:username]+:: New username that has been chosen by user
  #
  # Author: Mina Nagy
  def twitter_screen_name_clash
    auth = session['devise.twitter_data']
    raise ActiveResource::UnauthorizedAccess.new('Unauthorized') unless auth

    if params[:username]
      auth.chosen_user_name = params[:username]
      render and return if User.exists? username: params[:username]
      @user = User.create_user_from_twitter_oauth(auth)
      unless handle_oauth_login
        flash[:alert] = @user.errors.to_a[0] if @user.errors
        redirect_to new_user_registration_path
      end
    end
  end

  protected
  def after_sign_up_path_for(resource)
    if resource.type.is_a? Committee
      '/users/expertise'
    else
      '/'
    end
  end

  def after_inactive_sign_up_path_for(resource)
    if resource.type.is_a? Committee
      '/users/expertise'
    else
      '/'
    end
  end
end
