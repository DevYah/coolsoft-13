class Competition < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :investor
  has_many :competition_entries
  has_many :ideas, :through => :competition_entries, :source => :idea
  belongs_to :winner, :class_name => 'Idea', :foreign_key => 'idea_id'
  has_and_belongs_to_many :tags
  has_many :competition_notifications, :dependent => :destroy
  has_many :competition_idea_notifications, :dependent => :destroy
  has_many :delete_competition_notifications
end
