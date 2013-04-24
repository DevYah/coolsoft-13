class Competition < ActiveRecord::Base

  attr_accessible :description, :title

  has_many :ideas
  belongs_to :investor, :class_name => 'User'
  has_and_belongs_to_many :tags
  has_one :winner, :class_name => 'Idea'
end
