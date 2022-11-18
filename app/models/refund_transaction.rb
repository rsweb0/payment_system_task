# frozen_string_literal: true

class RefundTransaction < Transaction
  alias charge_transaction parent_transaction

  validates :amount, numericality: { greater_than: 0 }

  before_validation :set_necessary_fields
  after_create :update_merchant_transaction_sum

  private

  def set_necessary_fields
    self.amount = charge_transaction&.amount
    self.customer_email = charge_transaction&.customer_email
    self.customer_phone = charge_transaction&.customer_phone
  end

  def update_merchant_transaction_sum
    merchant.update!(total_transaction_sum: merchant.total_transaction_sum - amount) if approved?
  end
end
