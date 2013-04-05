class Invited < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :admin
end
