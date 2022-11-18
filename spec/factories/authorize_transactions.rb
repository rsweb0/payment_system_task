# frozen_string_literal: true

FactoryBot.define do
  factory :authorize_transaction, class: AuthorizeTransaction, parent: :transaction do
    amount { Faker::Number.positive }
    association :merchant
  end
end
