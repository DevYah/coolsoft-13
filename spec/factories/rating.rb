require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :rating, :class => Rating do |f|
    f.name 'rating-perspective'
    f.value 0
  end
end