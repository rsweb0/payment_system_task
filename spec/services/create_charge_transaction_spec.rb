# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateChargeTransaction, type: :service do
  describe '#call' do
    let(:authorize_transaction) { create(:authorize_transaction) }
    let(:invalid_authorize_transaction) { build(:authorize_transaction, amount: Faker::Number.negative) }
    let(:result) { described_class.call(context) }
    let(:model) { ChargeTransaction }

    context 'with valid arguments' do
      let(:context) do
        {
          authorize_transaction: authorize_transaction,
          merchant: authorize_transaction.merchant
        }
      end

      it 'should create a authorize transaction' do
        expect(model.count).to eq(0)
        result
        expect(model.count).to eq(1)
      end

      it 'service call should be succes' do
        expect(result.success?).to eq(true)
      end

      it 'should assign charge_transaction correctly' do
        charge_transaction = result.charge_transaction
        expect(charge_transaction.is_a?(model)).to eq(true)
        expect(charge_transaction.persisted?).to eq(true)
        expect(charge_transaction.approved?).to eq(true)
        expect(charge_transaction.authorize_transaction).to eq(authorize_transaction)
      end
    end

    context 'with invalid arguments' do
      let(:context) do
        {
          authorize_transaction: invalid_authorize_transaction,
          merchant: invalid_authorize_transaction.merchant
        }
      end

      it 'should not create authorize transaction' do
        expect(model.count).to eq(0)
        result
        expect(model.count).to eq(0)
      end

      it 'service call should be succes' do
        expect(result.success?).to eq(false)
      end

      it 'should assign errors correctly' do
        expect(result.errors).to eq(['Amount must be greater than 0'])
      end
    end
  end
end
