class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #username is unique
  validates :username, :uniqueness => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username, :date_of_birth, :type, :active, :first_name, :last_name,
                  :gender, :about_me, :recieve_vote_notification,
                  :recieve_comment_notification, :provider, :uid , :photo


  has_many :idea_notifications
  has_many :user_notifications
  has_many :ideas
  has_many :comments
  has_many :user_ratings
  has_many :idea_notifications_users
  has_many :idea_notifications, :through => :idea_notifications_users
  has_many :user_notifications_users
  has_many :user_notifications, :through => :user_notifications_users
  has_and_belongs_to_many :comments, :join_table => :likes
  has_and_belongs_to_many :likes, :class_name => 'Comment', :join_table => :likes
  has_and_belongs_to_many :votes, :class_name => 'Idea', :join_table => :votes  
  has_attached_file :photo, :styles => { :small => "60x60>", :medium => "300x300>" , :thumb => "10x10!" }, :default_url => "/images/:style/missing.png"
end
