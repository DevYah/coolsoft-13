require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :user, :class => User do |f|
   f.email 'marwa'
   f.password '123123123'
  end

  factory :user_two, :class => User do |f|
   f.email 'marwa2'
  end

  factory :admin, :class => User do |f|
   f.email 'marwa3'
   f.type 'Admin'
  end
end