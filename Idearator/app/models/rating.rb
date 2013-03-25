class Rating < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :idea
  has_many :users, :through => :user_rating
  has_many :user_ratings
end
