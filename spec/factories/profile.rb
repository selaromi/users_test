# -*- encoding : utf-8 -*-
require 'faker'
FactoryGirl.define do
  factory :profile do
    address Faker::Address.street_address
    city Faker::Address.city
    country Faker::Address.country_code
    postal_code Faker::Address.postcode
    full_name Faker::Name.name
    nationality Faker::Address.country
    identification_number Faker::Lorem.characters(10)
    identification_type Faker::Lorem.characters(10)
    date_of_birth Faker::Date.birthday
  end
end