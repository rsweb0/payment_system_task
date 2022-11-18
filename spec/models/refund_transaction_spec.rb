# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefundTransaction, type: :model do
  it { expect(described_class).to be < Transaction }

  describe 'aasm states' do
    it 'should have correct aasm states' do
      expect(subject).to have_state(:approved)
    end

    it 'should have not have other transaction event' do
      expect(subject).to have_state(:approved)
      expect(subject).not_to transition_from(:approved).to(:reversed).on_event(:reversed)
      expect(subject).not_to transition_from(:approved).to(:refunded).on_event(:refunded)
    end
  end

  it 'should have alias authorize_transaction of parent_transaction' do
    refund_transaction = create(:refund_transaction)
    expect(refund_transaction.charge_transaction).not_to eq(nil)
    expect(refund_transaction.charge_transaction).to eq(refund_transaction.parent_transaction)
  end

  describe 'set_necessary_fields' do
    let!(:refund_transaction) { create(:refund_transaction) }
    it 'should set necessary fields correctly' do
      charge_transaction = refund_transaction.charge_transaction
      expect(refund_transaction.amount).to eq(charge_transaction.amount)
      expect(refund_transaction.customer_email).to eq(charge_transaction.customer_email)
      expect(refund_transaction.customer_phone).to eq(charge_transaction.customer_phone)
      expect(refund_transaction.merchant).to eq(charge_transaction.merchant)
    end
  end

  describe 'update_merchant_transaction_sum' do
    let(:merchant) { create(:merchant) }
    let(:authorize_transaction) { create(:authorize_transaction, merchant: merchant) }
    let(:charge_transaction) { create(:charge_transaction, parent_transaction: authorize_transaction) }
    let(:refund_transaction) { create(:refund_transaction, parent_transaction: charge_transaction) }

    it 'should update merchant transaction sum correctly' do
      expect(merchant.total_transaction_sum).to eq(0)
      charge_transaction
      expect(merchant.reload.total_transaction_sum).to eq(authorize_transaction.amount)
      refund_transaction
      expect(merchant.reload.total_transaction_sum).to eq(0)
    end
  end
end
