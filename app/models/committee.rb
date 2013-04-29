class Committee < User
  # attr_accessible :title, :body
  has_many :approved_ideas, :class_name => 'Idea'
  has_and_belongs_to_many :tags
end
