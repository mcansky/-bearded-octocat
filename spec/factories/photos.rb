require 'factory_girl'

FactoryGirl.define do
  factory :photo do
    desc Faker::Lorem.sentence
  end
end