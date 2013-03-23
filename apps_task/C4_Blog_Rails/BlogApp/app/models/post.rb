class Post < ActiveRecord::Base
 
  attr_accessible :content, :title, :blog_id
  belongs_to :blog
  has_many :comments

  searchable do 
  	text :title, :content

  end
end
