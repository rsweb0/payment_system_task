# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReversalTransaction, type: :model do
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
    reversal_transaction = create(:reversal_transaction)
    expect(reversal_transaction.authorize_transaction).not_to eq(nil)
    expect(reversal_transaction.authorize_transaction).to eq(reversal_transaction.parent_transaction)
  end

  describe 'set_necessary_fields' do
    let!(:reversal_transaction) { create(:reversal_transaction) }
    it 'should set necessary fields correctly' do
      authorize_transaction = reversal_transaction.authorize_transaction
      expect(reversal_transaction.amount).to eq(nil)
      expect(reversal_transaction.customer_email).to eq(authorize_transaction.customer_email)
      expect(reversal_transaction.customer_phone).to eq(authorize_transaction.customer_phone)
      expect(reversal_transaction.merchant).to eq(authorize_transaction.merchant)
    end
  end
end
