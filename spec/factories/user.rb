require 'faker'
require 'factory_girl_rails'
FactoryGirl.define do
  factory :user, :class => User do |f|
  	f.email 'Dayna'
  end

  factory :user_two, :class => User do |f|
  	f.email 'Dayna2'
  end
end
