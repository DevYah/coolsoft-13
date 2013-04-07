class AdminsController < ApplicationController
  def show_users
      @users = User.all
      respond_to do |format|
        format.html  # index.html.erb
        format.json  { render :json => @posts }
    end
  end
  def approve_committeee
    @user = User.find(params[:id])
    @user.type = 'Committee'
    respond_to do |format|
       if @user.save
         format.html  { redirect_to(admins_path,
                       :notice => 'User successfully initiated as a Committee.') }
         format.json  { head :no_content }
       else
         format.html  { redirect_to(admins_path,
                       :notice => @user.errors.full_messages) }
         format.json  { render :json => :no_content }
       end
     end
   end
   def reject_committee
     @user = User.find(params[:id])
     respond_to do |format|
        if @user.save
          format.html  { redirect_to(admins_path,
                        :notice => 'User successfully initiated as a Committee.') }
          format.json  { head :no_content }
        else
          format.html  { redirect_to(admins_path,
                        :notice => @user.errors.full_messages) }
          format.json  { render :json => :no_content }
        end
      end
    end
end