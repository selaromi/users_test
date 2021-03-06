require 'faker'
FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    username Faker::Internet.user_name
    password Faker::Internet.password
  end
end