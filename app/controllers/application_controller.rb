# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_merchant

  private

  def authenticate_merchant!
    return if current_merchant.present?

    respond_to do |format|
      format.html { redirect_to login_path, notice: 'Please Sign in to continue!' }
      format.json do
        render_error(message: 'Please Sign in to continue!', status: 401, error_code: :merchant_not_logged_in)
      end
    end
  end

  def current_merchant
    @current_merchant ||= Merchant.active.find_by(id: session[:merchant_id]) if session[:merchant_id]
  end

  def render_active_record_error(error:, status: 422, error_code: status)
    render_error(
      message: error.full_messages.to_sentence,
      status: status,
      error_code: error_code
    )
  end

  def render_error(message:, status: 422, error_code: status)
    render json: { error: message, error_code: error_code }, status: status
  end
end
