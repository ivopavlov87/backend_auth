require "logging/logs"

class UserCreator
  include Logging::Logs
  def create_user(user)
    user.save
    
    if user.invalid?
      return Result.new(created: false, user: user)
    end


    log user, "created"
    Result.new(created: user.valid?, user: user)
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
