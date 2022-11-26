# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_merchant!
  before_action :validate_transaction_type, if: :transaction_type
  before_action :set_transaction, if: :transaction_type

  def new; end

  def create
    result = service.call(service_context)
    if result.success?
      flash[:notice] = 'Transaction created successfully!'
    else
      flash[:alert] = result.errors.first
    end
    redirect_to root_path
  end

  private

  def validate_transaction_type
    return if service_parent_mapping.keys.include?(transaction_type)

    flash[:notice] = "Invalid Transaction type: #{transaction_type}"
    redirect_to root_path
  end

  def transaction_type
    params[:transaction_type]
  end

  def service
    service_suffix = if transaction_type
                       transaction_type.camelize
                     else
                       'AuthorizeTransaction'
                     end
    "Create#{service_suffix}".constantize
  end

  def service_context
    if transaction_type
      { merchant: current_merchant, parent_association => @transaction }
    else
      transaction_params.merge(merchant: current_merchant)
    end
  end

  def set_transaction
    association = parent_association.pluralize
    @transaction = current_merchant.public_send(association).referencable_transactions.find_by(id: params[:transaction_id])
  end

  def parent_association
    service_parent_mapping[transaction_type]
  end

  def service_parent_mapping
    {
      'charge_transaction' => 'authorize_transaction',
      'refund_transaction' => 'charge_transaction',
      'reversal_transaction' => 'authorize_transaction'
    }
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :customer_email, :customer_phone)
  end
end
