# frozen_string_literal: true

class TransactionSerializer < ActiveModel::Serializer
  attributes :id,
             :amount,
             :type,
             :status,
             :customer_email,
             :customer_phone,
             :created_at,
             :processed

  def created_at
    object.created_at.strftime('%d/%m/%y %H:%M')
  end

  def amount
    object.amount&.round(2)
  end

  def processed
    transactions = instance_options[:transactions]
    if object.authorize_transaction?
      !object.approved? || transactions.find { |t| t.parent_transaction_id == object.id }
    elsif object.charge_transaction?
      !object.approved?
    else
      true
    end
  end
end
