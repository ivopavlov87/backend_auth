# frozen_string_literal: true

class User < ApplicationRecord
	require "securerandom"

	has_secure_password

	validates :email, presence: true, uniqueness: true
	validate :valid_email

	validates :username, presence: true, uniqueness: true

	def valid_email
		unless email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      errors.add(:email, "#{email}, is not a valid email")
    end
	end
end
