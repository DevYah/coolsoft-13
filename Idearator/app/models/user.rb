
class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #username is unique
  validates :username, :uniqueness => true
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :twitter]
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :title, :body
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username, :date_of_birth, :type, :active, :first_name, :last_name,
                  :gender, :about_me, :recieve_vote_notification,
                  :recieve_comment_notification, :provider, :uid , :photo, :approved

  has_many :idea_notifications
  has_many :user_notifications
  has_many :ideas
  has_many :comments
  has_many :user_ratings
  has_and_belongs_to_many :idea_notifications
  has_and_belongs_to_many :user_notifications
  has_and_belongs_to_many :comments, :join_table => :likes
  has_and_belongs_to_many :ideas, :join_table => :votes
  has_many :authorizations
  has_and_belongs_to_many :likes, :class_name => 'Comment', :join_table => :likes
  has_and_belongs_to_many :votes, :class_name => 'Idea', :join_table => :votes
  has_attached_file :photo, :styles => { :small => '60x60>', :medium => "300x300>",:thumb => '10x10!' }, :default_url => '/images/:style/missing.png'
  has_and_belongs_to_many :likes, :class_name => 'Comment', :join_table => :likes
  has_and_belongs_to_many :votes, :class_name => 'Idea', :join_table => :votes

# this method finds the +User+ using the hash and creates a new +User+ 
# if no users with this email exist
#
# Params:
#
# +auth+:: omniauth authentication hash
# +signed_in_resource+:: Currently signed in resource. Unused.
#
#Author: Menna Amr
def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(username:auth.extra.raw_info.username,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
  end
  user
  end

  # Find a +User+ by the twitter auth data. Uses +provider+ and +uid+ fields to
  # find the user.
  # Params:
  # +auth+:: omniauth authentication hash
  # +signed_in_resource+:: Currently signed in resource. Unused.
  #
  # Author: Mina Nagy
  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      # FIXME handle failure
      user = create_user_from_twitter_oauth(auth)
    end
    user
  end

  # Try to create a +User+ from the twitter authentication hash
  # Params:
  # +auth+:: omniauth authentication hash
  #
  # Author: Mina Nagy
  def self.create_user_from_twitter_oauth(auth)
    name = auth.info.name.split(' ', 2)
    user = User.create(first_name: name[0],
                       last_name: name[1],
                       provider: auth.provider,
                       uid: auth.uid,
                       # this is an invalid email, but uniqueness is guaranteed
                       email: "#{auth.info.nickname}@twitter.com",
                       username: (auth.chosen_user_name or auth.info.nickname),
                       # random password, won't hurt
                       password: Devise.friendly_token[0, 20])
  end
end

