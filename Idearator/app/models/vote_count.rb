class VoteCount < ActiveRecord::Base
  attr_accessible :prev_day_votes, :curr_day_votes
  belongs_to :idea
end
