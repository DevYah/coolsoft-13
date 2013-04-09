module OmniauthHandlerMixin
  def handle_oauth_login
    if @user.persisted?
      @user.confirm!
      set_flash_message(:notice, :success, :kind => @user.provider.to_s.capitalize) if is_navigational_format?
      if params[:state] == 'popup'
        sign_in @user, :event => :authentication
        render 'devise/registrations/close_login_popup', :layout => false
      else
        sign_in_and_redirect @user, :event => :authentication
      end
      return true
    else
      return false
    end
  end
end

