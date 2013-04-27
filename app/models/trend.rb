class Trend < ActiveRecord::Base
  attr_accessible :vote, :idea_id , :trending , :created_at
  has_many :ideas
end
