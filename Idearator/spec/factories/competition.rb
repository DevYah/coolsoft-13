require 'faker'

FactoryGirl.define do
  factory :competition do |f|
    f.title Faker::Name.name
    f.description Faker::Lorem.paragraph
    f.start_date 2.days.ago
    f.end_date 8.days.since Time.now.to_date
    f.tags [ Tag.new(:name => 'Science')]
  end

end