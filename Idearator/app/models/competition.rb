class Competition < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :investor
  has_and_belongs_to_many :ideas
  belongs_to :idea
  has_and_belongs_to_many :tags
end
