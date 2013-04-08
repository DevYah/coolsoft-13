class Committee < User
  # attr_accessible :title, :body
  has_many :ideas
  has_and_belongs_to_many :tags
end
