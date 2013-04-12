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
  end
end