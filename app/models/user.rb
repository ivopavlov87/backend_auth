# frozen_string_literal: true

# User model
class User < ApplicationRecord
  require 'securerandom'

  has_secure_password
  validate :complex_password

  validates :email, presence: true, uniqueness: true
  validate :valid_email

  validates :username, presence: true, uniqueness: true
  validate :valid_username

  def valid_email
    return if email =~ /\A([\w+-].?)+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i

    errors.add(:email, "#{email}, is not a valid email")
  end

  def check_password_for_number
    return if ('0'..'9').to_a.any? { |num| password&.include?(num) }

    errors.add(:password, 'must contain at least 1 number')
  end

  def check_password_for_capital_letter
    return if ('A'..'Z').to_a.any? { |char| password&.include?(char) }

    errors.add(:password, 'must contain at least 1 capital letter')
  end

  def check_password_for_lowercase_letter
    return if ('a'..'z').to_a.any? { |char| password&.include?(char) }

    errors.add(:password, 'must contain at least 1 lowercase letter')
  end

  def check_password_for_special_character
    special_chars = %w{@ % + ! # $ ^ ? : ( ) [ ] ~ - . _}
    return if special_chars.any? { |special_char| password&.include?(special_char) }

    # rubocop:disable Layout/LineLength
    errors.add(:password, 'must contain at least one of the following special characters: @ % + . ! # $ ^ ? : ( ) [ ] ~ - _ and cannot contain other special characters')
    # rubocop:enable Layout/LineLength
  end

  def check_username_characters
    valid_chars = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a + ['_']

    return if username&.chars&.all? { |username_char| valid_chars.include?(username_char) }

    errors.add(:username, 'must contain only underscores and alphanumeric characters')
  end

  def complex_password
    check_password_for_number

    check_password_for_capital_letter

    check_password_for_lowercase_letter

    check_password_for_special_character
  end

  def valid_username
    check_username_characters

    errors.add(:username, 'cannot start with an underscore') if username&.chars&.first == '_'

    errors.add(:username, 'cannot end with an underscore') if username&.chars&.last == '_'
  end
end
