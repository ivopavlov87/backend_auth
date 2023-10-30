# frozen_string_literal: true

class User < ApplicationRecord
	require "securerandom"

	has_secure_password
	validate :complex_password

	validates :email, presence: true, uniqueness: true
	validate :valid_email

	validates :username, presence: true, uniqueness: true
	validate :valid_username

	def valid_email
		unless email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      errors.add(:email, "#{email}, is not a valid email")
    end
	end

	def complex_password
		unless ("0".."9").to_a.any? { |num| password&.include?(num) }
      errors.add(:password, "must contain at least 1 number")
    end

    unless ("A".."Z").to_a.any? { |char| password&.include?(char) }
      errors.add(:password, "must contain at least 1 capital letter")
    end

    unless ("a".."z").to_a.any? { |char| password&.include?(char) }
      errors.add(:password, "must contain at least 1 lowercase letter")
    end

    special_chars = ['@', '%', '+', '!', '#', '$', '^', '?', ':', '(', ')', '[', ']', '~', '-', '.', '_']
    unless special_chars.any? { |special_char| password&.include?(special_char) }
      errors.add(:password, "must contain at least one of the following special characters: @ % + . ! # $ ^ ? : ( ) [ ] ~ - _ and cannot contain other special characters")
    end
	end

	def valid_username
		valid_chars = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a + ["_"]

    unless username&.chars&.all? { |username_char| valid_chars&.include?(username_char) }
      errors.add(:username, "must contain only underscores and alphanumeric characters")
    end

    if username&.chars&.first == "_"
      errors.add(:username, "cannot start with an underscore")
    end

    if username&.chars&.last == "_"
      errors.add(:username, "cannot end with an underscore")
    end
	end
end
