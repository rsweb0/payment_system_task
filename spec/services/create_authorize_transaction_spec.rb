# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateAuthorizeTransaction, type: :service do
  describe '#call' do
    let(:customer_email) { Faker::Internet.email }
    let(:customer_phone) { Faker::PhoneNumber.cell_phone_in_e164 }
    let(:merchant) { create(:merchant) }
    let(:valid_amount) { Faker::Number.positive }
    let(:invalid_amount) { Faker::Number.negative }
    let(:result) { described_class.call(context) }
    let(:model) { AuthorizeTransaction }

    context 'with valid arguments' do
      let(:context) do
        {
          amount: valid_amount,
          customer_email: customer_email,
          customer_phone: customer_phone,
          merchant: merchant
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

      it 'should assign authorize_transaction correctly' do
        authorize_transaction = result.authorize_transaction
        expect(authorize_transaction.is_a?(model)).to eq(true)
        expect(authorize_transaction.persisted?).to eq(true)
        expect(authorize_transaction.amount).to eq(valid_amount)
        expect(authorize_transaction.customer_email).to eq(customer_email)
        expect(authorize_transaction.customer_phone).to eq(customer_phone)
        expect(authorize_transaction.merchant).to eq(merchant)
      end
    end

    context 'with invalid arguments' do
      let(:context) do
        {
          amount: invalid_amount,
          customer_email: customer_email,
          customer_phone: customer_phone,
          merchant: merchant
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
