class CommitteesController < ApplicationController
  def review_ideas 
    @committee=Committee.find(1)
    if @committee.type == "Committee"
      @ideas=Idea.find(:all, :conditions =>{:approved => false})
      @ideas.reject! do |i|
        (i.tags & @committee.tags).empty?         
      end
    end  	
  end
  def Disapprove
    @idea=Idea.find(session[:idea_id])
    @idea.approved = false
    @idea.save
  end  
  def test

  end
  def add_rating
    @idea=Idea.find(session[:idea_id])
    @idea.approved = true
    @idea.save
    @rating = params[:rating]
    @rating.each do |rate|
      r = @idea.ratings.build
      r.name=rate
      r.value=0
      r.save
    end  
    respond_to do |format|
      format.js {render "add_rating"}
    end

  end
  	
end
