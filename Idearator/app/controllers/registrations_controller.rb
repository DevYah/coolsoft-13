class RegistrationsController < Devise::RegistrationsController
  protected
   
#Redirecting to sign in page after sign up
#Author: Menna Amr

    def after_sign_up_path_for(resource)
      if resource.type.is_a? Committee
        "/users/expertise"
      else
        "/"
      end
    end        

    def after_inactive_sign_up_path_for(resource)
      if resource.type.is_a? Committee
        "/users/expertise"
      else
        "/"
      end
>>>>>>> 41fdd78191d2607026f5afbf06988c7ad6748cd0
    end        
end
