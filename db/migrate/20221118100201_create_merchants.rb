# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :description
      t.string :email
      t.integer :status
      t.float :total_transaction_sum, default: 0
      t.string :password_digest

      t.timestamps
    end
  end
end
