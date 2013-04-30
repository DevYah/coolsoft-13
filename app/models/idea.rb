class Idea < ActiveRecord::Base

  attr_accessible :title, :description, :problem_solved, :photo, :num_votes, :user_id, :approved, :tag_ids

  validates_length_of :title, :maximum => 50
  validates_length_of :description, :maximum => 1000
  validates_length_of :problem_solved, :maximum => 1000

  after_save TrendsController::IdeaHooks.new

  belongs_to :user
  belongs_to :committee
  has_one :daily_vote_count, class_name: 'VoteCount'
  has_many :comments
  has_many :idea_notifications, :dependent => :destroy
  has_many :competition_idea_notifications, :dependent => :destroy
  has_many :delete_notifications
  has_many :ratings
  has_and_belongs_to_many :tags
  has_many :votes
  has_many :voters, :through => :votes, :source => :user
  has_many :competition_entries
  has_many :competitions, :through => :competition_entries, :source => :competition
  has_many :winning_competitions, :class_name => 'Competition'
  has_one :trend

  has_attached_file :photo, :styles => { :small => '60x60>', :medium => "300x300>", :thumb => '10x10!' }, :default_url => '/images/:style/missing.png'
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end

  def send_edit_notification(user)
    voters=self.votes
    voters.each{|u|
      if u.participated_idea_notifications
        EditNotification.send_notification(user, self, [u])
      end
    }
    commenters=Comment.where(idea_id: self.id)
    commenters.each{ |c|
     if c.participated_idea_notifications
      EditNotification.send_notification(user, self, [c])
     end }
  end
end
