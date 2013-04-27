class Vote < ActiveRecord::Base
  attr_accessible :user_id, :idea_id

  belongs_to :user
  belongs_to :idea
end
