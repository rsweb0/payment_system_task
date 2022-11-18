# frozen_string_literal: true

class Transaction < ApplicationRecord
  include AASM

  aasm column: :status do
    state :approved, initial: true
    state :refunded, :reversed, :error

    event :reversed do
      transitions from: :approved, to: :reversed, guard: :authorize_transaction?
    end

    event :refunded do
      transitions from: :approved, to: :refunded, guard: :charge_transaction?
    end
  end

  belongs_to :merchant
  belongs_to :parent_transaction, polymorphic: true, optional: true

  validates :customer_email, :customer_phone, presence: true, unless: :error?
  validates :status, presence: true
  validate :parent_transaction_must_have_same_merchant

  private

  def authorize_transaction?
    is_a?(AuthorizeTransaction)
  end

  def charge_transaction?
    is_a?(ChargeTransaction)
  end

  def parent_transaction_must_have_same_merchant
    return unless parent_transaction && parent_transaction.merchant != merchant

    errors.add(:merchant, 'Parent transaction merchant and merchant should be same')
  end
end
