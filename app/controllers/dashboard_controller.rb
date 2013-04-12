class DashboardController < ApplicationController
  #Method to add values to rows in table to draw a chart
  #Author:Lina Basheer
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
  def getideas
    @tagid = params[:tagid]
    @ideastagsall = IdeasTags.find(:all, :conditions => {:tag_id => @tagid})
    @ideasall = Idea.where(:id => @ideastagsall.map(&:idea_id))
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Idea')
    data_table.new_column('datetime'  , 'Date')
    data_table.new_column('number', 'Idea number')
    data_table.new_column('number', 'Number of votes')
    @no = 0
    @ideasall.each do |i|
      @no = @no + 1
      data_table.add_rows([
      [i.title, i.created_at, i.user_id, i.num_votes]
      ])
    end
    opts   = { :width => 900, :height => 500 }
    @chart = GoogleVisualr::Interactive::MotionChart.new(data_table, opts)
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
end
