require 'faker'

FactoryGirl.define do
  factory :investor do |i|
    i.email  Faker::Internet.email
    i.username  Faker::Name.name
    i.password  123123123
  end

end