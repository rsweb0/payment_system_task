# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    flash_classes[level.to_sym]
  end

  private

  def flash_classes
    {
      notice: 'alert alert-success',
      alert: 'alert alert-danger'
    }
  end
end
