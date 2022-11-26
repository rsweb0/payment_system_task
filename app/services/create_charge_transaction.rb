# frozen_string_literal: true

# CreateChargeTransaction.call(
#   authorize_transaction: authorize_transaction,
#   merchant: merchant
# )
class CreateChargeTransaction
  include Interactor

  delegate :authorize_transaction, :merchant, to: :context

  def call
    validate_transaction if authorize_transaction
    charge_transaction = build_charge_transaction

    if charge_transaction.save
      context.charge_transaction = charge_transaction
    else
      context.fail!(errors: charge_transaction.errors.full_messages)
    end
  end

  private

  def build_charge_transaction
    merchant.charge_transactions.build(
      parent_transaction: authorize_transaction,
      status: authorize_transaction ? :approved : :error
    )
  end

  def validate_transaction
    return if authorize_transaction.charge_transaction.blank?

    context.fail!(errors: ['Can not charge already charged transaction!'])
  end
end
