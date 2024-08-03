# frozen_string_literal: true

# ApplicationJob
class ApplicationJob
  # noinspection RubyResolve
  # for Sidekiq::Worker declaration
  include Sidekiq::Worker

  sidekiq_options backtrace: true
end
