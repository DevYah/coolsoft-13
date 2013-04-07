class DashboardController < ApplicationController
  def index
    @tagid = params[:tagid]
    @ideastagsall = IdeasTags.find(:all, :conditions => {:tag_id => params[:tagid]})
    @ideasall = Idea.where(:id => @ideastagsall.map(&:idea_id))
    ###############
    @ideaid = params[:ideaid]
    @ideatagsthen = IdeasTags.find(:all, :conditions => {:idea_id => @ideaid})
    @ideatags = Tag.where(:id => @ideatagsthen.map(&:tag_id))
    #########
    @user = current_user
    @ideas = Idea.find(:all, :conditions => {:user_id => @user.id})
    #########
    respond_to do |format|
    format.html
    format.js
    end
  end
end