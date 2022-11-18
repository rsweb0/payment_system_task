# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  has_one :charge_transaction, as: :parent_transaction, dependent: :restrict_with_error,
                               inverse_of: :parent_transaction

  has_one :reversal_transaction, as: :parent_transaction, dependent: :restrict_with_error,
                                 inverse_of: :parent_transaction

  validates :amount, numericality: { greater_than: 0 }, unless: :error?
end
