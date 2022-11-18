# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    email { Faker::Internet.unique.email }
    status { :active }
    total_transaction_sum { 0 }
    password { 'payment@321' }
  end
end
