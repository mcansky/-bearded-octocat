require 'factory_girl'

FactoryGirl.define do
  factory :photo do
    desc Faker::Lorem.sentence
  end
  factory :old_photo, :class => Photo do
    desc Faker::Lorem.sentence
    created_at Time.now - 8.days
  end
end