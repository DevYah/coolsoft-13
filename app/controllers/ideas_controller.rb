class IdeasController < ApplicationController
  def show()
  end

  def filter()
  @approved = Idea.joins(:tags).where(:tags => {:name => params[:myTags]}).page(params[:page]).per(10)
  @tags = params[:myTags]  
    respond_to do |format|
        format.js
        format.json  { render :json => @approved }
    end
  end
end
