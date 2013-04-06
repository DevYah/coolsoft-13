class Rating < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :idea
  has_many :users, :through => :user_rating
  has_many :user_ratings

  def average_rating
    @value = 0
    self.user_ratings.each do |user_rating|
      @value = @value + user_rating.value
    end
    @total = self.user_ratings.size
    @value.to_f / @total.to_f
  end
end