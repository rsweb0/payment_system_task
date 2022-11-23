# frozen_string_literal: true

# CreateReversalTransaction.call(
#   authorize_transaction: authorize_transaction,
#   merchant: merchant
# )
class CreateReversalTransaction
  include Interactor

  delegate :authorize_transaction, :merchant, to: :context

  def call
    validate_transaction if authorize_transaction
    reversal_transaction = build_reversal_transaction

    if reversal_transaction.save
      authorize_transaction.reversed!
      context.reversal_transaction = reversal_transaction
    else
      context.fail!(errors: reversal_transaction.errors.full_messages)
    end
  end

  private

  def build_reversal_transaction
    merchant.reversal_transactions.build(
      parent_transaction: authorize_transaction,
      status: authorize_transaction ? :approved : :error
    )
  end

  def validate_transaction
    return unless authorize_transaction.reversal_transaction.exists?

    context.fail!(errors: ['Can not reverse already reveresed transaction!'])
  end
end
