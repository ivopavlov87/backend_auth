require "logging/logs"

class UserCreator
  include Logging::Logs
  def create_user(user)
    user.save
    
    if user.invalid?
      return Result.new(created: false, user: user)
    end


    log user, "created"
    NewUserRegisteredJob.perform_async(user.id)
    Result.new(created: user.valid?, user: user)
  end

  def new_user_account_registered(user_id)
    user = User.find(user_id)
    NewUserMailer.new_user_account_created(user).deliver_now
  end

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
