class Idea < ActiveRecord::Base

  attr_accessible :title, :description, :problem_solved, :photo, :num_votes, :user_id, :approved, :tag_ids

  validates_length_of :title, :maximum => 50
  validates_length_of :description, :maximum => 1000
  validates_length_of :problem_solved, :maximum => 1000

  belongs_to :user
  has_one :vote_count
  has_many :comments
  has_many :idea_notifications, :dependent => :destroy
  has_many :delete_notifications
  has_many :ratings
  belongs_to :committee
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :votes, :class_name => 'User', :join_table => :votes
  has_attached_file :photo, :styles => { :small => '60x60>', :medium => "300x300>", :thumb => '10x10!' }, :default_url => '/images/:style/missing.png'
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end
end
