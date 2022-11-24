# frozen_string_literal: true

class MerchantsController < ApplicationController
  before_action :authenticate_merchant!, only: :show

  def show; end
end
