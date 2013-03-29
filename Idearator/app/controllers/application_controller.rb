class ApplicationController < ActionController::Base
  protect_from_forgery
	# redirect committee members to controller user action expertise for their first sign in 
	# Params:
	# none
	# Author: Mohamed Sameh
  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1 
    	if current_user.is_a? Committee
    		"/users/expertise"
    	else
    		"/"
    	end
    else
    	"/"
    end
  end
end
