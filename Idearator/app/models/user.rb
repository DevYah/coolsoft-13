class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #username is unique
  validates :username, :uniqueness => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username, :date_of_birth, :type, :active, :first_name,
                  :last_name, :gender, :about_me, :recieve_vote_notification,
                  :recieve_comment_notification, :provider, :uid

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
  has_and_belongs_to_many :likes, :class_name => 'Comment', :join_table => :votes
  has_and_belongs_to_many :votes, :class_name => 'Idea', :join_table => :votes

  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      # username may already be taken, user will have to enter another one
      if not User.where(username: auth.extra.raw_info.screen_name).empty?
        # FIXME handle failure
        user = create_user_from_twitter_oauth(auth)
      else
        auth.redirect = { controller: '/registrations', action: 'twitter_screen_name_clash' }
      end
    end
    user
  end

  def self.create_user_from_twitter_oauth(auth)
    name = auth.info.name.split(' ', 2)
    user = User.create(first_name: name[0],
                       last_name: name[1],
                       provider: auth.provider,
                       uid: auth.uid,
                       # this is an invalid email, but uniqueness is guaranteed
                       email: "#{auth.extra.raw_info.screen_name}@twitter.com",
                       username: (auth.chosen_user_name or auth.extra.raw_info.screen_name),
                       # random password, won't hurt
                       password: Devise.friendly_token[0, 20])
  end

end

