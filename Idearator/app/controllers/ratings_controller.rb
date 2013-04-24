class RatingsController < ApplicationController

  # auto completes rating perspectives
  # Params:
  # +q+:: the parameter is  a string passed through auttocomplete field
  # Author: muhammed hassan
  def ajax
    @ratings = Rating.find(:all, :select =>'DISTINCT name', conditions: ['name LIKE(?)', "%#{ params[:q] }%"]).uniq
    @ratings << Rating.new(name: params[:q])
    render :json => @ratings , only: [:name,:id]
  end

end
