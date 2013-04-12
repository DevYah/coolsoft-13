require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :user, :class => User do |f|
   f.email 'marwa'
   f.password '123123123'
  end
  factory :admin, :class => User do |f|
   f.email 'ay7aga'
   f.type 'Admin'
   f.password 'mahmoudhashish'
  end

  factory :user_two, :class => User do |f|
    f.email 'ay7aga'
    f.password 'mahmoudhashish'
  end
end