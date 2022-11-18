# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'aasm states' do
    it 'should have correct aasm states' do
      expect(subject).to have_state(:approved)
    end
  end

  it { should belong_to(:merchant) }
  it { should belong_to(:parent_transaction).optional }
  it { should validate_presence_of(:customer_email) }
  it { should validate_presence_of(:customer_phone) }
  it { should validate_presence_of(:status) }
end
