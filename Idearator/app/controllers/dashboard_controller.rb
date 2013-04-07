class DashboardController < ApplicationController
  #Method to add values to rows in table to draw a chart
  #Author:Lina Basheer

  def index
    @tagid = params[:tagid]
    @ideastagsall = IdeasTags.find(:all, :conditions => {:tag_id => params[:tagid]})
    @ideasall = Idea.where(:id => @ideastagsall.map(&:idea_id))
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Idea')
    data_table.new_column('datetime'  , 'Date')
    data_table.new_column('number', 'idea number')
    data_table.new_column('number', 'number of votes')
    @ideasall.each do |i|
    data_table.add_rows([
    [i.title, i.created_at, i.user_id, i.num_votes]
    ])
    end

       opts   = { :width => 900, :height => 500 }
       @chart = GoogleVisualr::Interactive::MotionChart.new(data_table, opts)
    ###############
    @ideaid = params[:ideaid]
    @ideatagsthen = IdeasTags.find(:all, :conditions => {:idea_id => @ideaid})
    @ideatags = Tag.where(:id => @ideatagsthen.map(&:tag_id))
    #########
    @user = User.find(3)
    @ideas = Idea.find(:all, :conditions => {:user_id => @user.id})
    #########
    respond_to do |format|
    format.html
    format.js

    end
  end
end

