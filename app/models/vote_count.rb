class VoteCount < ActiveRecord::Base
  attr_accessible :votes
  belongs_to :idea
end
