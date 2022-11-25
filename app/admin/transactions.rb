# frozen_string_literal: true

ActiveAdmin.register Transaction do
  actions :index, :show

  index do
    id_column
    column :amount
    column :type
    column :status
    column :parent_transaction
    column :customer_email
    column :customer_phone
    column :merchant
    column :created_at
    column :updated_at
    actions
  end
end
