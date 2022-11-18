# frozen_string_literal: true

class ReversalTransaction < Transaction
  alias authorize_transaction parent_transaction

  validates :amount, absence: true
  before_validation :set_necessary_fields

  private

  def set_necessary_fields
    self.amount = nil
    self.customer_email = authorize_transaction&.customer_email
    self.customer_phone = authorize_transaction&.customer_phone
  end
end
