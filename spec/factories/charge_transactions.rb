# frozen_string_literal: true

FactoryBot.define do
  factory :charge_transaction, class: ChargeTransaction, parent: :transaction do
    parent_transaction { create(:authorize_transaction) }
    merchant { parent_transaction.merchant }
  end
end
