# frozen_string_literal: true
env :PATH, ENV['PATH']

set :output, 'log/cron.log'

ENV.each { |k, v| env(k, v) }

every 1.hour do
  runner 'DeleteOlderTransactionsJob.perform_now'
end
