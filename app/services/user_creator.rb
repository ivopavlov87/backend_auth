# frozen_string_literal: true

require 'logging/logs'

# User Creator service class
class UserCreator
  include Logging::Logs
  def create_user(user)
    user.save

    return Result.new(created: false, user:) if user.invalid?

    log user, 'created'
    NewUserRegisteredJob.perform_async(user.id)
    Result.new(created: user.valid?, user:)
  end

  def new_user_account_registered(user_id)
    user = User.find(user_id)
    NewUserMailer.new_user_account_created(user).deliver_now
  end

  # Result class for User Creator Service
  class Result
    attr_reader :user

    def initialize(created:, user:)
      @created = created
      @user = user
    end

    def created?
      @created
    end
  end
end
