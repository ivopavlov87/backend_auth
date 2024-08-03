# frozen_string_literal: true

# New User Registered Job sends an email when a new user account is created
class NewUserRegisteredJob < ApplicationJob
  def perform(user_id)
    UserCreator.new.new_user_account_registered(user_id)
  end
end
