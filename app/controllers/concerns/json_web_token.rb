# frozen_string_literal: true

require 'jwt'
# JSON Web-Token for authentication purposes
module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY = ENV['JWT_SECRET_KEY']

  def jwt_encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY).first
    HashWithIndifferentAccess.new decoded
  end
end
