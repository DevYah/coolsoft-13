class TagsController < ApplicationController
# auto completes tags
# Params:
# +q+:: the parameter is  a string passed through auttocomplete field
# Author: muhammed hassan
  def ajax
    @tags = Tag.find(:all, conditions: ['name LIKE(?)', "%#{ params[:q] }%"]).take(5)
    render :json => @tags , only: [:id, :name]
  end 
end
