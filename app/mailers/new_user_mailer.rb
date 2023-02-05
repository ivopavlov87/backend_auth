class NewUserMailer < ApplicationMailer
  def new_user_account_created(user)
    @user = user
    mail to: @user.email
  end
end
