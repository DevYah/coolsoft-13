class StreamController < ApplicationController

  #This is the action that controls the stream through having 4 aparameters manipulated in a way that they change the
  #value of the @ideas that is sent
  #+params+:mypage,search,tag,search_user
  #Mohamed Salah Nazir
  def index
    @top = Idea.find(:all, :conditions => { :approved => true }, :order=> 'num_votes desc', :limit=>10)
    @page = params[:mypage]
    @searchtext = params[:search]
    @filter = params[:tag].to_a
    @search_with_user = params[:search_user] == "true"
    @searching_with = params[:searchtype] == "true"

    if @page != nil
      if !@search_with_user
        if @searchtext.to_s.strip.length == 0 and @filter.empty?
          @ideas = Idea.order(:created_at).page(params[:mypage]).per(10)
          respond_to do |format|
            format.html
            format.js
          end
        else
          if @searchtext.to_s.strip.length > 0 and @filter.empty?
            @ideas = Idea.search(params[:search]).order(:created_at).page(params[:mypage]).per(10)
          else
            @ideas = Idea.filter(@filter).sort{|i1,i2| i1.created_at <=> i2.created_at}.uniq
            @ideas = Kaminari.paginate_array(@ideas).page(params[:mypage]).per(10)
          end
        end
      else
        @users = User.search(params[:search]).page(params[:mypage]).per(10)
      end
    else
      if @searchtext.nil?
        @ideas = Idea.order(:created_at).page(1).per(10)
      else
        if !@searching_with
          @ideas = Idea.search(params[:search]).order(:created_at).page(params[:mypage]).per(10)
        else
          @users = User.search(params[:search]).page(params[:mypage]).per(10)
        end
      end
    end
  end
end
