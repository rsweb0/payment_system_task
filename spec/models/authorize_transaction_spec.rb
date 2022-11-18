# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeTransaction, type: :model do
  it { expect(described_class).to be < Transaction }

  describe 'aasm states' do
    it 'should have correct aasm states' do
      expect(subject).to have_state(:approved)
      expect(subject).to transition_from(:approved).to(:reversed).on_event(:reversed)
      expect(subject).to have_state(:reversed)
    end

    it 'should have not have other transaction event' do
      expect(subject).to have_state(:approved)
      expect(subject).not_to transition_from(:approved).to(:refunded).on_event(:refunded)
      expect(subject).not_to have_state(:refunded)
    end
  end

  it {
    should have_one(:charge_transaction).dependent(:restrict_with_error).inverse_of(:parent_transaction)
  }
  it {
    should have_one(:reversal_transaction).dependent(:restrict_with_error).inverse_of(:parent_transaction)
  }
end
