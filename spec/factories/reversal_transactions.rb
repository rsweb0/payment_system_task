# frozen_string_literal: true

FactoryBot.define do
  factory :reversal_transaction, class: ReversalTransaction, parent: :transaction do
    parent_transaction { create(:authorize_transaction) }
    merchant { parent_transaction.merchant }

    after(:create) do |reversal_transaction|
      reversal_transaction.authorize_transaction.reversed!
    end
  end
end
