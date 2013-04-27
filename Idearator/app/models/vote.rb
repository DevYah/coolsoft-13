class Vote < ActiveRecord::Base
  attr_accessible :user_id, :idea_id, :created_at
  
  after_save TrendsController::VoteHooks.new

  belongs_to :user
  belongs_to :idea
end
