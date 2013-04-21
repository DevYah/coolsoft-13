class RegistrationsController < Devise::RegistrationsController
  protected
   
#Redirecting to sign in page after sign up

    def after_sign_up_path_for(resource)
      if resource.type.is_a? Committee
        '/users/expertise'
        ApproveCommitteeNotification.send_notification(resource,Admin.all)
      else
        '/'
      end
    end

    def  after_inactive_sign_up_path_for(resource)
      if resource.type.is_a? Committee
        '/users/expertise'
        ApproveCommitteeNotification.send_notification(resource,Admin.all)
      else
        '/'
      end
    end
end
