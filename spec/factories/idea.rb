require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :idea do |f|
    f.title 'c1'
    f.description 'description of c 1'
    f.problem_solved 'problem solved of c 1'
  end
end
