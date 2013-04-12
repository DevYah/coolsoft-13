class HomeController < ApplicationController
  #Used to display the idea stream, top ten and trending ideas.
  #Author: Hesham Nabil
  #Method gets all ideas, order them in descending order according to number of votes
  #and sends top ten ideas to index view page
  #Author: Lina Basheer
  #ideas stream can be feltered according to selected tags
  #Author: Muhammed Hassan
  def index
    @top = Idea.find(:all, :conditions => { :approved => true }, :order=> 'num_votes desc', :limit=>10)
    if(params[:myTags])
      if(params[:myTags].length>0)
        tags = Array(params[:myTags])
        tags.map! { |e| e.delete(' ') }
        @approved = Idea.joins(:tags).where(:tags => {:name => tags}).page(params[:myPage].to_i).per(10)
      else
        @approved = Idea.order(:created_at).page(params[:myPage]).per(10)
      end
    else
        @approved = Idea.order(:created_at).page(params[:myPage]).per(10) 
    end
        respond_to do |format|
          format.js
          format.html # index.html.erb
          format.xml  { render :xml => @approved }
        end
  end 
end

