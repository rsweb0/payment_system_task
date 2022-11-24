# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate_merchant!, only: :destroy

  def new; end

  def create
    merchant = Merchant.find_by(email: params[:email])
    if merchant&.authenticate(params[:password])
      session[:merchant_id] = merchant.id
      flash[:success] = 'Login successful'
      redirect_to root_path
    else
      flash[:notice] = 'Invalid Email or Password'
      redirect_to login_path
    end
  end

  def destroy
    session[:merchant_id] = nil
    flash[:notice] = 'Logged Out'
    redirect_to '/login'
  end
end
