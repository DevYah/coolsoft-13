class Vote < ActiveRecord::Base
  attr_accessible :user_id, :idea_id
end
