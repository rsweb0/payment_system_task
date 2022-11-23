# frozen_string_literal: true

# CreateAuthorizeTransaction.call(
#   amount: amount,
#   customer_email: customer_email,
#   customer_phone: customer_phone,
#   merchant: merchant
# )
class CreateAuthorizeTransaction
  include Interactor

  delegate :amount, :customer_email, :customer_phone, :merchant, to: :context

  def call
    authorize_transaction = build_authorize_transaction

    if authorize_transaction.save
      context.authorize_transaction = authorize_transaction
    else
      context.fail!(errors: authorize_transaction.errors.full_messages)
    end
  end

  private

  def build_authorize_transaction
    merchant.authorize_transactions.build(
      amount: amount,
      customer_email: customer_email,
      customer_phone: customer_phone
    )
  end
end
