# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateReversalTransaction, type: :service do
  describe '#call' do
    let(:authorize_transaction) { create(:authorize_transaction) }
    let(:invalid_authorize_transaction) { build(:authorize_transaction, customer_email: nil) }
    let(:result) { described_class.call(context) }
    let(:model) { ReversalTransaction }

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

      it 'should assign reversal_transaction correctly' do
        reversal_transaction = result.reversal_transaction
        expect(reversal_transaction.is_a?(model)).to eq(true)
        expect(reversal_transaction.persisted?).to eq(true)
        expect(reversal_transaction.approved?).to eq(true)
        expect(reversal_transaction.authorize_transaction).to eq(authorize_transaction)
      end

      it 'should change charge_transaction status to refunded' do
        expect(authorize_transaction.approved?).to eq(true)
        result
        expect(authorize_transaction.reload.reversed?).to eq(true)
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
        expect(result.errors).to eq(["Customer email can't be blank"])
      end
    end
  end
end
