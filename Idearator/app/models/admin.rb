class Admin < User
  # attr_accessible :title, :body

  has_and_belongs_to_many :inviteds
end
