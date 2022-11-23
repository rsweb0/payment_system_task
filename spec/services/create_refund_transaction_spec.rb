# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateRefundTransaction, type: :service do
  describe '#call' do
    let(:charge_transaction) { create(:charge_transaction) }
    let(:invalid_charge_transaction) { build(:charge_transaction, amount: Faker::Number.negative) }
    let(:result) { described_class.call(context) }
    let(:model) { RefundTransaction }

    context 'with valid arguments' do
      let(:context) do
        {
          charge_transaction: charge_transaction,
          merchant: charge_transaction.merchant
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

      it 'should assign refund_transaction correctly' do
        refund_transaction = result.refund_transaction
        expect(refund_transaction.is_a?(model)).to eq(true)
        expect(refund_transaction.persisted?).to eq(true)
        expect(refund_transaction.approved?).to eq(true)
        expect(refund_transaction.charge_transaction).to eq(charge_transaction)
      end

      it 'should change charge_transaction status to refunded' do
        expect(charge_transaction.approved?).to eq(true)
        result
        expect(charge_transaction.reload.refunded?).to eq(true)
      end
    end

    context 'with invalid arguments' do
      let(:context) do
        {
          charge_transaction: invalid_charge_transaction,
          merchant: invalid_charge_transaction.merchant
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
