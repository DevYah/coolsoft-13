class IdeasController < ApplicationController
  def show()
  end

  def filter()
  @ideas = Idea.joins(:tags).where(:tags => {:name => params[:myTags]})
  render :json => @ideas
  end
end
