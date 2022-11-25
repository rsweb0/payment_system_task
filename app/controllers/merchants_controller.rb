# frozen_string_literal: true

class MerchantsController < ApplicationController
  before_action :authenticate_merchant!, only: :show

  def show
    transactions = current_merchant.transactions.recent_first.includes(:parent_transaction)
    @serialized_transactions = ActiveModel::SerializableResource.new(transactions).as_json
  end
end
