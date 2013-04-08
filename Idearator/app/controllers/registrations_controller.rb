class RegistrationsController < Devise::RegistrationsController
  def twitter_screen_name_clash
    auth = session['devise.twitter_data']
    raise ActiveResource::UnauthorizedAccess.new('Unauthorized') unless auth

    if params[:username]
      auth.chosen_user_name = params[:username]
      render and return if User.exists? username: params[:username]
      user = User.create_user_from_twitter_oauth(auth)
      if not user
        user.confirm!
        sign_in_and_redirect @user, :event => :authentication
        set_flash_message(:notice, :success, :kind => provider.to_s.capitalize) if is_navigational_format?
      else
        flash[:alert] = user.errors.to_a[0]
        redirect_to controller: 'twitter_screen_name_clash'
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
