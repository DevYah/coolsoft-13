class ApplicationController < ActionController::Base
  protect_from_forgery
  #check for first sign in of committee member, he will be redirected to choose his area of expertise
  def after_sign_in_path_for(resource)
  	puts current_user.sign_in_count
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
