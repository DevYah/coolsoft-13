class RegistrationsController < Devise::RegistrationsController
  protected
   
#Redirecting to sign in page after sign up

       def after_sign_up_path_for(resource)
      "users/sign_in"
    end        
end
