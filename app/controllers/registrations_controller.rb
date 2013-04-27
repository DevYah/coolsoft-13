class RegistrationsController < Devise::RegistrationsController
  include OmniauthHandlerMixin

  # This method overrides the original devise method in order to show the list of tags the user can choose
  # from if they signed up as a committee member
  #
  # params: None
  #
  # Author: Menna Amr
  def new
    @tags = Tag.all
    super
  end



  protected


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

  # Deny the user from Signing In if User is banned
  #
  # Params: +resrouce+:: The user object
  #
  # Author: Menna Amr
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.banned?
      sign_out resource
      flash[:error] = "This account has been suspended."
      root_path
    else
      super
    end
   end
end
