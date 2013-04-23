require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :user, :class => User do |f|
    f.email 'ay7aga'
  end

  factory :user_two, :class => User do |f|
    f.email 'ay7aga2'
  end
end