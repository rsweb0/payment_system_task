# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_secure_password

  enum status: { active: 0, inactive: 1 }

  validates :name, :description, :email, :status, presence: true
  validates :total_transaction_sum, numericality: { greater_than_or_equal_to: 0 }

  has_many :transactions, dependent: :restrict_with_error
  has_many :authorize_transactions, dependent: :restrict_with_error
  has_many :charge_transactions, dependent: :restrict_with_error
  has_many :refund_transactions, dependent: :restrict_with_error
  has_many :reversal_transactions, dependent: :restrict_with_error
end
