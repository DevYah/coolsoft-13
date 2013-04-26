class Competition < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :investor
  has_and_belongs_to_many :ideas
  belongs_to :winner, :class_name => 'Idea', :foreign_key => 'idea_id'
  has_and_belongs_to_many :tags
end