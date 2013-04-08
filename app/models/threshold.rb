class Threshold < ActiveRecord::Base
  attr_accessible :threshold

  def self.threshold_run
    Threshold.create(:threshold => VoteCount.maximum('curr_day_votes'))
    @vote_counts = VoteCount.all
    VoteCount.all.each do |v|
      v.prev_day_votes = v.curr_day_votes
      v.curr_day_votes = 0
    end
  end
end
