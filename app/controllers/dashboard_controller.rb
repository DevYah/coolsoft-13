class DashboardController < ApplicationController
  before_filter :authenticate_user!, :only => [:index]
  def index
    @user = current_user
    @threshold = Threshold.last
    if @user.type == 'Committee'
      @approved_ideas = Idea.where(:committee_id => @user.id)
      @approved_thresholds = Array.new
      @approved_ideas.each do |idea|
        @v = VoteCount.find(:first, :conditions => { :idea_id => idea.id})
        @percent = (@v.prev_day_votes * 100) / @threshold.threshold
        if @percent == 0
          @approved_thresholds << 1
        elsif @percent < 50
          @approved_thresholds << 2
        else
          @approved_thresholds << 3
        end
      end
    end
    @own_ideas = Idea.where(:user_id => @user.id, :approved => true)
    @own_thresholds = Array.new
    @own_ideas.each do |idea|
        @v = VoteCount.find(:first, :conditions => { :idea_id => idea.id})
        @percent = (@v.prev_day_votes * 100) / @threshold.threshold
        if @percent == 0
          @own_thresholds << 1
        elsif @percent < 50
          @own_thresholds << 2
        else
          @own_thresholds << 3
        end
    end
    @counter = 1
  end
end