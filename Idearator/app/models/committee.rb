class Committee < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :password
  has_and_belongs_to_many :ideas
  has_and_belongs_to_many :tags
end
