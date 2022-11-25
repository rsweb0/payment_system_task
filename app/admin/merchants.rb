# frozen_string_literal: true

ActiveAdmin.register Merchant do
  permit_params :name, :description, :email, :status, :total_transaction_sum, :password

  index do
    id_column
    column :name
    column :email
    column :description
    column :status
    column :total_transaction_sum
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :description
      row :status
      row :total_transaction_sum
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :email
      f.input :description
      f.input :status
      f.input :password
    end
    f.actions
  end
end
