require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :comment do |f|
    f.content 'c1'
   
  end
end
