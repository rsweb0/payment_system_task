# frozen_string_literal: true

# rubocop:disable Rails/Output
unless AdminUser.exists?
  AdminUser.create!(email: 'admin@paymentsystem.com', password: 'payment@321',
                    password_confirmation: 'payment@321')
  puts 'Adminuser with email: admin@paymentsystem.com created'
end

unless Merchant.exists?
  FactoryBot.create(:merchant, email: 'merchant1@paymentsystem.com', password: 'payment@321')
  puts 'Merchant with email: merchant1@paymentsystem.com created'
  FactoryBot.create(:merchant, email: 'merchant2@paymentsystem.com', password: 'payment@321')
  puts 'Merchant with email: merchant2@paymentsystem.com created'
end
