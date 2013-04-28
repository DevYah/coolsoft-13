class Trend < ActiveRecord::Base
  attr_accessible :vote, :idea_id , :trending , :created_at , :rounds
  has_many :ideas
end
