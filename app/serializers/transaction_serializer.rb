# frozen_string_literal: true

class TransactionSerializer < ActiveModel::Serializer
  attributes :id,
             :amount,
             :type,
             :status,
             :customer_email,
             :customer_phone,
             :created_at

  belongs_to :parent_transaction

  def created_at
    object.created_at.strftime('%d/%m/%y %H:%M')
  end

  def amount
    object.amount.round(2)
  end
end
