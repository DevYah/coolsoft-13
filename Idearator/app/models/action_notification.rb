class ActionNotification < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  belongs_to :idea
end
