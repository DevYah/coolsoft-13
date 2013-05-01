class RatingsController < ApplicationController

# auto completes rating perspectives
# Params:
# +q+:: the parameter is  a string passed through auttocomplete field
# Author: muhammed hassan
  def ajax
    @ratings = Rating.find(:all, conditions: ['name LIKE(?)', "%#{ params[:q] }%"]).take(5)
    render :json => @ratings , only: [:name,:id]
  end


end