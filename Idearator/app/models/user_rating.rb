class UserRating < ActiveRecord::Base
  attr_accessible :value
  belongs_to :user
  belongs_to :rating
end
