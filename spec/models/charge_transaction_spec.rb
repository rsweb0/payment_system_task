# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChargeTransaction, type: :model do
  it { expect(described_class).to be < Transaction }
  let(:subject) { build(:charge_transaction) }

  describe 'aasm states' do
    it 'should have correct aasm states' do
      expect(subject).to have_state(:approved)
      expect(subject).to transition_from(:approved).to(:refunded).on_event(:refunded)
      expect(subject).to have_state(:refunded)
    end

    it 'should have not have other transaction event' do
      expect(subject).to have_state(:approved)
      expect(subject).not_to transition_from(:approved).to(:reversed).on_event(:reversed)
      expect(subject).not_to have_state(:reversed)
    end
  end

  it 'should have alias authorize_transaction of parent_transaction' do
    charge_transaction = create(:charge_transaction)
    expect(charge_transaction.authorize_transaction).not_to eq(nil)
    expect(charge_transaction.authorize_transaction).to eq(charge_transaction.parent_transaction)
  end

  it {
    should have_one(:refund_transaction).dependent(:restrict_with_error).inverse_of(:parent_transaction)
  }

  describe 'set_necessary_fields' do
    let!(:charge_transaction) { create(:charge_transaction) }
    it 'should set necessary fields correctly' do
      authorize_transaction = charge_transaction.authorize_transaction
      expect(charge_transaction.amount).to eq(authorize_transaction.amount)
      expect(charge_transaction.customer_email).to eq(authorize_transaction.customer_email)
      expect(charge_transaction.customer_phone).to eq(authorize_transaction.customer_phone)
      expect(charge_transaction.merchant).to eq(authorize_transaction.merchant)
    end
  end

  describe 'update_merchant_transaction_sum' do
    let(:merchant) { create(:merchant) }
    let(:authorize_transaction) { create(:authorize_transaction, merchant: merchant) }
    let(:charge_transaction) { create(:charge_transaction, parent_transaction: authorize_transaction) }

    it 'should update merchant transaction sum correctly' do
      expect(merchant.total_transaction_sum).to eq(0)
      charge_transaction
      expect(merchant.reload.total_transaction_sum).to eq(authorize_transaction.amount)
    end
  end
end
