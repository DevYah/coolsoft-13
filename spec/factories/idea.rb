require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :idea do |f|
    f.title 'ay7aga'
    f.description 'ay7aga'
    f.problem_solved 'ay 7aga'
  end
end