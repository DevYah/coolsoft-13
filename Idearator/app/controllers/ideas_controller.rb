class IdeasController < ApplicationController
  def show
  	@user=Committee.find(1)
  	@idea=Idea.find(params[:id])
  end
end
