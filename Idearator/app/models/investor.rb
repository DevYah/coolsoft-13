class Investor < User
  has_many :competitions
  def self.model_name
    User.model_name
  end
end
