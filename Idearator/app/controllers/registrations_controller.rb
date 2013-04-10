class RegistrationsController < Devise::RegistrationsController
 
  #This method overrides the original devise method in order to show the list of tags the user can choose
  #from if they signed up as a committee member
  #params:
  #Author: Menna Amr
  def new
    @tags = Tag.all
    super
  end
  
  #This method overrides the original devise method to ensure the use
  #actually chose their area(s) of expertise and throw an error message if
  #none were chosen
  #params:
  #Author: Menna Amr
  def create
    build_resource
    
    @tags = Tag.all

    if resource.type == "Committee" && params[:tags].nil?
      set_flash_message :error, :select_expertise
      redirect_to "/users/sign_up" and return
    end

    if resource.save
      if resource.type == "Committee"
        UserMailer.committee_signup("menna.amr2@gmail.com").deliver
        resource.becomes(Committee).tag_ids = params[:tags]
      end 

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end  
end