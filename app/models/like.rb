class Like < ActiveRecord::Base
  attr_accessible :user_id, :comment_id
  validates_uniqueness_of :user_id, :scope => [:comment_id]

end
