class Competition < ActiveRecord::Base

 attr_accessible :title, :description ,:start_date ,:end_date, :tag_ids

  validates_length_of :title, :maximum => 50
  validates_length_of :description, :maximum => 1000

  belongs_to :investor
  has_and_belongs_to_many :ideas
  belongs_to :winner, :class_name => 'Idea', :foreign_key => 'idea_id'
  has_and_belongs_to_many :tags

  def open
    return  end_date > Time.now.to_date
  end

end
