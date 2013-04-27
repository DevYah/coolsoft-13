class TrendsController < ApplicationController

  class VoteHooks
    def after_save(vote)
      v = Vote.find(:all , :conditions => { :idea_id  => vote.idea_id }, :order => 'created_at desc', :limit=> 2 )
      diff = v[0].created_at - v[1].created_at
      puts(diff.to_i)
      if diff.to_i < 200
        t = Trend.find_by_idea_id(vote.idea_id)
        t.trending = t.trending + 4
      end
      if diff.to_i <400 && diff.to_i >200
        t = Trend.find_by_idea_id(vote.idea_id)
        t.trending = t.trending + 2
      end    
      if diff.to_i <1200 && diff.to_i >400
        t = Trend.find_by_idea_id(vote.id)
        t.trending = t.trending + 1
      end    

    end
  end

  def self.trends_run
    @trending = Idea.find(:all, :conditions => { :approved => true }, :order=> 'trending desc', :limit=>4)
  end

end
