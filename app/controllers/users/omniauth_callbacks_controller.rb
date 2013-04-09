class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniauthHandlerMixin

  def default_oauth_callback(&on_fail)
    auth = request.env['omniauth.auth']

    @user = User.send("find_for_#{auth.provider.to_s}_oauth", auth, current_user)
    unless @user.persisted?
      # save oauth data if user creation failed
      session["devise.#{auth.provider.to_s}_data"] = auth.except(:extra)
    end
    auth.fail_redirect ||= new_user_registration_path

    unless handle_oauth_login
      if on_fail
        yield auth
      else
        default_oauth_fail
      end
    end
  end

  def default_oauth_fail
    auth = request.env['omniauth.auth']
    session.delete("devise.#{auth.provider.to_s}_data")
    flash[:alert] = @user.errors.to_a[0] if @user.errors
    redirect_to auth.fail_redirect
  end

  def facebook
    default_oauth_callback
  end

  def twitter
    default_oauth_callback do |auth|
      # username may already be taken, user will have to enter another one
      if User.exists? username: auth.info.nickname
        redirect_to controller: '/registrations', action: 'twitter_screen_name_clash'
      else
        default_oauth_fail
      end
    end
  end
end
