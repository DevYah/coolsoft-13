class Vote < ActiveRecord::Base
  attr_accessible :user_id, :idea_id

  after_create ::FacebookApiVote.new

  belongs_to :user
  belongs_to :idea , :counter_cache =>  'num_votes'
  validates_uniqueness_of :user_id, :scope => :idea_id

end
