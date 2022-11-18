# frozen_string_literal: true

FactoryBot.define do
  factory :refund_transaction, class: RefundTransaction, parent: :transaction do
    parent_transaction { create(:charge_transaction) }
    merchant { parent_transaction.merchant }

    before(:create) do |refund_transaction|
      refund_transaction.charge_transaction.refunded!
    end
  end
end
