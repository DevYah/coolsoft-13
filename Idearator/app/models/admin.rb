class Admin < User
  # attr_accessible :title, :body

  has_many :inviteds
  def self.model_name
    User.model_name
  end
end
