class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def default_oauth_callback(provider, &block)
    auth = request.env['omniauth.auth']

    @user = User.send("find_for_#{provider.to_s}_oauth", auth, current_user)
    unless @user && @user.persisted?
      # save oauth data if user creation failed
      session["devise.#{provider.to_s}_data"] = auth
    end

    if block
      yield auth
    else
      if @user && @user.persisted?
        @user.confirm!
        sign_in_and_redirect @user, :event => :authentication # this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => provider.to_s.capitalize) if is_navigational_format?
      else
        redirect_to auth.redirect if auth.redirect
      end
    end
  end

  def facebook
    default_oauth_callback(:facebook)
  end

  def twitter
    default_oauth_callback(:twitter)
  end
end
