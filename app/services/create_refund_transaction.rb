# frozen_string_literal: true

# CreateRefundTransaction.call(
#   charge_transaction: charge_transaction,
#   merchant: merchant
# )
class CreateRefundTransaction
  include Interactor

  delegate :charge_transaction, :merchant, to: :context

  def call
    validate_transaction if charge_transaction
    refund_transaction = build_refund_transaction

    if refund_transaction.save
      charge_transaction.refunded!
      context.refund_transaction = refund_transaction
    else
      context.fail!(errors: refund_transaction.errors.full_messages)
    end
  end

  private

  def build_refund_transaction
    merchant.refund_transactions.build(
      parent_transaction: charge_transaction,
      status: charge_transaction ? :approved : :error
    )
  end

  def validate_transaction
    return unless charge_transaction.refund_transaction.exists?

    context.fail!(errors: ['Can not refund already refunded transaction!'])
  end
end
