require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :user, :class => User do |f|
  	f.email 'ay7aga'
  	f.password 'mahmoudhashish'
  end

  factory :user_two, :class => User do |f|
  	f.email 'ay7aga2'
  end

  factory :admin, :class => User do |f|
  	f.email 'ay7aga3'
  	f.type 'Admin'
  end
  factory :committee, :class => User do |f|
    f.email 'ay7aga4'
    f.type 'Committee'
#    f.tags [FactoryGirl.create(:tag)]
  end
    
end