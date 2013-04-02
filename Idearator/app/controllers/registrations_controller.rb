class RegistrationsController < Devise::RegistrationsController
  protected
   
#Redirect committee member to choosing expertise page

    def after_sign_up_path_for(resource)
      if resource.type.is_a? Committee
        "/users/expertise"
      else
        "/"
      end
    end        

#make sure user is "active" (confirmed)
    def after_inactive_sign_up_path_for(resource)
      puts "DEBUSG"
      puts resource
      puts resource.to_s
      puts resource.type
      if resource.type.is_a? Committee
        "www.google.com"
      else
        "/"
      end
    end        
end
