require 'faker'
require 'factory_girl_rails'
require "spec_helper"

describe User do
  it "orders by id" do
FactoryGirl.define do
  factory :user, :class => User do |f|
  	f.email 'Dayna'
  end

  factory :user_two, :class => User do |f|
  	f.email 'Dayna2'
  end
end
end
end