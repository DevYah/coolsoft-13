class IdeasController < ApplicationController
  def show()
  end

  def filter()
  @approved = Idea.joins(:tags).where(:tags => {:name => params[:myTags]})
    respond_to do |format|
        format.js
        format.html  { render :template => 'home/index' }
        format.json  { render :json => @approved }
    end
  end
end
