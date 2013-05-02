require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :competition do |f|
    f.title 'competition1'
    f.description 'description of competition 1'
    f.start_date '2-22-2013'
    f.end_date '2-22-2014'
  end

  factory :competition_two, :class => Competition do |f|
    f.title 'competition2'
    f.description 'description of competition 2'
    f.start_date '2-24-2013'
    f.end_date '2-24-2014'
  end

  factory :invalid_competition, parent: :competition do |f|
    f.title nil
  end
end