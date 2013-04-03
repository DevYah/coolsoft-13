class IdeaNotifications < ActiveRecord::Base
  belongs_to :idea
  belongs_to :user
  attr_accessible :link, :type
end
