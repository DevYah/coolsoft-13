class Idea < ActiveRecord::Base
  
  attr_accessible :title, :description, :problem_solved, :photo, :num_votes, :user, :user_id, :approved, :tag_ids, :created_at
  
  validates_length_of :title, :maximum => 50
  validates_length_of :description, :maximum => 1000
  validates_length_of :problem_solved, :maximum => 1000
  validates :description,
        :presence => {:message => "can't be blank"}
  after_save ::FacebookApiCreate.new
  after_save ::TrendsController::IdeaHooks.new
  after_save ::SimilarityEngine::IdeaHooks.new

  belongs_to :user
  belongs_to :committee
  has_one :daily_vote_count, class_name: 'VoteCount'
  has_many :comments
  has_many :idea_notifications, :dependent => :destroy
  has_many :competition_idea_notifications, :dependent => :destroy
  has_many :delete_notifications
  has_many :ratings
  has_and_belongs_to_many :tags

  validates :tags,
        :presence => {:message => "can't be blank"}

  has_many :votes
  has_many :voters, :through => :votes, :source => :user
  has_many :competition_entries
  has_many :competitions, :through => :competition_entries, :source => :competition
  has_many :winning_competitions, :class_name => 'Competition'
  has_one :trend

  has_many :similarities
  has_many :similar_ideas, through: :similarities, conditions: ['similarity > ? AND approved = ? AND rejected = ?', 5, 't', 'f'], limit: 5

  has_attached_file :photo, :styles => { :small => '60x60>', :medium => "300x300>", :thumb => '10x10!' }, :default_url => 'missing.png'

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end

  def self.getDay_of_week(day)
    day_in_week = ""
    if day == 0
      day_in_week="Sunday"
    else
      if day == 1
        day_in_week = "Monday"
      else
        if day == 2
          day_in_week = "Tuesday"
        else
          if day == 3
            day_in_week = "Wednesday"
          else
            if day == 4
              day_in_week = "Thursday"
            else
              day_in_week = "Friday"
            end
          end
        end
      end
    end
  end

  def self.getDate(idea_id)
    idea_time = Idea.find(idea_id).created_at
    idea_date = Idea.find(idea_id).created_at.to_date
    curr_date = Time.now.to_date
    date = ""
    
      if idea_date.month == curr_date.month and idea_date.year == curr_date.year
        if curr_date.day - idea_date.day < 7
          if curr_date.day - idea_date.day == 1
            date = "Yesterday" + " at, " + idea_time.strftime("%H:%M")
          else
            date = Idea.getDay_of_week(idea_date.day) + " at, " + idea_time.strftime("%H:%M")
          end
        else
          date = Idea.getDay_of_week(idea_date.day) + " " +idea_date.day.to_s + " at, " + idea_time.strftime("%H:%M")
        end
      else
        if idea_date.month != curr_date.month and idea_date.year == curr_date.year
          date = Date::MONTHNAMES[idea_date.month] + " " + idea_date.day.to_s + ", " + Idea.getDay_of_week(idea_date.day)
        else
          date = Date::MONTHNAMES[idea_date.month] + " " + idea_date.day.to_s + ", " + idea_date.year.to_s
        end
      end
    
  end

  def self.filter(tags,search_parameter)
    ideas = []
    search_results = Idea.search(search_parameter)
    tags.each do |tag|
      t = Tag.find(:first, :conditions => {:name => tag})
      ideatags = IdeasTags.find(:all, :conditions => {:tag_id => t.id})
      tag_ideas = Idea.where(:id => ideatags.map(&:idea_id))
      ideas = ideas + tag_ideas
    end
    @results = ideas & search_results
  end

  #Adds the idea of the highest votes in the month of the input date
  #+date+::
  #Author Omar Kassem
  def self.best_idea_for_month(date)
    start_date = date
    start_date = start_date - (start_date.day - 1).day
    end_date = start_date + 1.month
    ideas = Idea.where(:created_at => start_date..end_date).reorder('num_votes')
    idea = MonthlyWinner.new
    puts ideas.count
    idea.idea_id = ideas.last.id
    idea.save
  end

  # send notification  to users who voted for this idea  when the idea submitter edit his idea
  # Params:
  # +user+:: the parameter instance of user
  # Author:: Marwa Mehanna
  def send_edit_notification(user)
    voters=self.voters
    voters.each{|u|
      if u.participated_idea_notifications
        EditNotification.send_notification(user, self, [u])
      end
    }
  end

  def approve(user)
    self.approved = true
    self.committee = user
    self.save
    IdeasController::CoolsterPusher.new.push_to_stream self
  end

  def votable?
    !archive_status && approved
  end

  def visible?(user=nil)
    commontags = []
    if user.is_a? Committee
      commontags = user.tags & self.tags
    end
    if !user.nil? && user == self.user || commontags != []
      true
    elsif self.approved
      true
    else
      false
    end
  end

end
