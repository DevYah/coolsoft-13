class IdeasController < ApplicationController
  def show
  	@user=current_user
  	@idea=Idea.find(params[:id])
  end
end
