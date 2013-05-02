require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do

  factory :notification_competition, :class => Competition do |f|
    f.title 'title'
    f.description 'description competition'
  end

end
