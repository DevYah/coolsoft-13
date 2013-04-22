class DashboardController < ApplicationController
before_filter :authenticate_user!, :only => [:index]
  # renders the view of the dashboard for idea submitters and committee members.
  # it checks the value of the current threshold, the user's ideas and committee's
  # approved ideas and calculates the corresponding percentage of the ideas in relation
  # to the threshold.
  # Params:
  # none
  # Author: Hisham ElGezeery
  
  def index
   @user = current_user
    @threshold = Threshold.last
    if @user.type == 'Committee'
      @approved_ideas = Idea.find(:all, :conditions => { :committee_id => @user.id})
      @approved_thresholds = Array.new
      @approved_ideas.each do |idea|
        @v = VoteCount.find(:first, :conditions => { :idea_id => idea.id})
        @percent = (@v.prev_day_votes * 100) / @threshold.threshold
        if @percent == 0
          @approved_thresholds << 0
        elsif @percent < 10
          @approved_thresholds << 1
        elsif @percent <20
          @approved_thresholds << 2
        elsif @percent < 30
          @approved_thresholds << 3
        elsif @percent < 40
          @approved_thresholds << 4
        elsif @percent < 50
          @approved_thresholds << 5
        elsif @percent < 60
          @approved_thresholds << 6
        elsif @percent < 70
          @approved_thresholds << 7
        elsif @percent < 80
          @approved_thresholds << 8
        elsif @percent < 90
          @approved_thresholds << 9
        else
          @approved_thresholds << 10
        end
      end
    end
      @own_ideas = Idea.find(:all, :conditions => { :user_id => @user.id})
      @own_thresholds = Array.new
      @own_ideas.each do |idea|
        @v = VoteCount.find(:first, :conditions => { :idea_id => idea.id})
        @percent = (@v.prev_day_votes * 100) / @threshold.threshold
        if @percent == 0
          @own_thresholds << 0
        elsif @percent < 10
          @own_thresholds << 1
        elsif @percent <20
          @own_thresholds << 2
        elsif @percent < 30
          @own_thresholds << 3
        elsif @percent < 40
          @own_thresholds << 4
        elsif @percent < 50
          @own_thresholds << 5
        elsif @percent < 60
          @own_thresholds << 6
        elsif @percent < 70
          @own_thresholds << 7
        elsif @percent < 80
          @own_thresholds << 8
        elsif @percent < 90
          @own_thresholds << 9
        else
          @own_thresholds << 10
        end
      end
    @approved_counter = 0
    @own_counter = 0
    respond_to do |format|
      format.html
      format.js
    end
  end
  #Method to add values to rows in table to draw a chart
  #Author:Lina Basheer

  def getideas
    @tagid = params[:tagid]
    @ideastagsall = IdeasTags.find(:all, :conditions => {:tag_id => @tagid})
    @ideasall = Idea.where(:id => @ideastagsall.map(&:idea_id))
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Idea')
    data_table.new_column('number', 'Number of votes')
    data_table.new_column('number', 'Idea number')
    @no = 0
    @ideasall.each do |i|
      @no = @no + 1
      data_table.add_rows([
      [i.title, i.num_votes ,i.user_id]
      ])
    end
    opts   = { :width => 900, :height => 500 }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
    

    respond_to do |format|
      format.html
      format.js
    end 
  end 

  #Method that gets all tags belonging to an idea,
  #+params[:idea_id]+ is the id of the idea the user clicks on
  #Author: Mohamed Salah Nazir
     
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
