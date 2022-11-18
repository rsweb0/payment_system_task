# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.float :amount
      t.string :status
      t.string :customer_email
      t.string :customer_phone
      t.string :type
      t.string :parent_transaction_type
      t.string :parent_transaction_id
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end

    add_index :transactions, %i[parent_transaction_type parent_transaction_id], name: :parent_transaction_index
  end
end
