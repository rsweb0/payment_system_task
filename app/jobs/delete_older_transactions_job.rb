# frozen_string_literal: true

class DeleteOlderTransactionsJob < ApplicationJob
  queue_as :default

  def perform
    Transaction.older_transactions.destroy_all
    puts "Older transactions deleted"
  end
end
