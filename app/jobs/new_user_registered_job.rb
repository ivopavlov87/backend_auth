class NewUserRegisteredJob < ApplicationJob
  def perform(user_id)
    UserCreator.new.new_user_account_registered(user_id)
  end
end
