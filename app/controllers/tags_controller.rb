class TagsController < ApplicationController
  def ajax
    @tags = Tag.find(:all, conditions: ['name LIKE(?)', "%#{ params[:q] }%"]).take(5)
    render :json => @tags , only: [:id, :name]
  end 
end
