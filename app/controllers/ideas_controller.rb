class IdeasController < ApplicationController
  def show()
  end
  # filters the ideas that have one or more of given tags
# Params:
# +tags:: the parameter is an list of +Tag+ passed through tag autocomplete field
# Author: muhammed hassan
  def filter()
  @approved = Idea.joins(:tags).where(:tags => {:name => params[:myTags]}).uniq.page(params[:page]).per(10)
  @tags = params[:myTags]  
    respond_to do |format|
        format.js
        format.json  { render :json => @approved }
    end
  end
end
