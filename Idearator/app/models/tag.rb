class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
   attr_accessible :name
   has_and_belongs_to_many :committees
   has_and_belongs_to_many :ideas
   has_and_belongs_to_many(:tags, :join_table => 'tag_connections', :foreign_key => 'tag_a_id', :association_foreign_key => 'tag_b_id')
end
