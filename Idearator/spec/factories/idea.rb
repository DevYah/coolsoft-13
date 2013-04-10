require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :idea1 do |f|
    f.title 'ay7aga'
    f.description 'ay7aga'
    f.problem_solved 'ay 7aga'
#    f.tags [ FactoryGirl.create(:tag) ]
    f.approved false
  end

  factory :idea2 do |f|
    f.title 'ay7aga'
    f.description 'ay7aga'
    f.problem_solved 'ay 7aga'
#   f.tags [FactoryGirl.create(:tag1)]
    f.approved false
  end

  factory :idea3 do |f|
    f.title 'ay7aga'
    f.description 'ay7aga'
    f.problem_solved 'ay 7aga'
#    f.tags [FactoryGirl.create(:tag)]
    f.approved true
  end    
end