# frozen_string_literal: true

class ChargeTransaction < Transaction
  alias authorize_transaction parent_transaction

  has_one :refund_transaction, as: :parent_transaction, dependent: :restrict_with_error,
                               inverse_of: :parent_transaction

  validates :amount, numericality: { greater_than: 0 }, unless: :error?

  before_validation :set_necessary_fields
  after_create :update_merchant_transaction_sum

  private

  def set_necessary_fields
    self.amount = authorize_transaction&.amount
    self.customer_email = authorize_transaction&.customer_email
    self.customer_phone = authorize_transaction&.customer_phone
  end

  def update_merchant_transaction_sum
    merchant.update!(total_transaction_sum: merchant.total_transaction_sum + amount) if approved?
  end
end
