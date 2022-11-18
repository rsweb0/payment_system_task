# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_secure_password }
  it { should define_enum_for(:status).with_values(%i[active inactive]) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:status) }
  it { should validate_numericality_of(:total_transaction_sum).is_greater_than_or_equal_to(0) }
  it { should have_many(:transactions).dependent(:restrict_with_error) }
end
