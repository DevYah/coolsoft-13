class Vote < ActiveRecord::Base
  attr_accessible :user_id, :idea_id

  belongs_to :user
  belongs_to :idea

  validates_uniqueness_of :user_id, :scope => :idea_id
end
