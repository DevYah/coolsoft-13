require 'faker'
require 'factory_girl_rails'
describe Comment do
	it " orders by the id" do
FactoryGirl.define do
  factory :comment do |f|
    f.title 'Test'
    f.description 'Test'
    f.problem_solved 'Test'
  end
end
end 
end