# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate_merchant!, only: :destroy

  def new; end

  def create
    merchant = Merchant.find_by(email: params[:email])
    if merchant&.authenticate(params[:password])
      session[:merchant_id] = merchant.id
      redirect_to root_path, notice: 'Login successful'
    else
      redirect_to login_path, alert: 'Invalid Email or Password'
    end
  end

  def destroy
    session[:merchant_id] = nil
    redirect_to login_path, notice: 'Logged Out'
  end
end
