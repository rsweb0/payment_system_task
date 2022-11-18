# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    customer_email { Faker::Internet.email }
    customer_phone { Faker::PhoneNumber.cell_phone_in_e164 }
  end
end
