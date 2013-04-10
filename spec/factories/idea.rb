require 'faker'
require 'factory_girl_rails'
FactoryGirl.define do
  factory :idea do |f|
    f.title 'Test'
    f.description 'Test'
    f.problem_solved 'Test'
  
end 
end