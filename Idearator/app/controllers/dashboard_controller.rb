class DashboardController < ApplicationController
  #Method that gets all tags belonging to an idea,
  #+params[:idea_id]+ is the id of the idea the user clicks on
  #Author: Mohamed Salah Nazir
  def index
    @user = current_user
    @ideas = Idea.find(:all, :conditions => {:user_id => @user.id})
    respond_to do |format|
    format.html
    format.js
    end
  end
  def gettags
    @ideaid = params[:ideaid]
    @ideatagsthen = IdeasTags.find(:all, :conditions => {:idea_id => @ideaid})
    @ideatags = Tag.where(:id => @ideatagsthen.map(&:tag_id))
    respond_to do |format|
    format.html
    format.js
    end
  end
  def getideas
    @tagid = params[:tagid]
    @ideastagsall = IdeasTags.find(:all, :conditions => {:tag_id => params[:tagid]})
    @ideasall = Idea.where(:id => @ideastagsall.map(&:idea_id))
    respond_to do |format|
    format.html
    format.js
    end
  end
end