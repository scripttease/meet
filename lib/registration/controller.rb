# frozen_string_literal: true

require "lib/result"
require "lib/user/model"

#
# Given some the credentials for a new user, create the user!
#
class RegistrationController
  MIN_PASSWORD_LENGTH = 7

  def initialize(user_repo: UserRepository.new)
    @user_repo = user_repo
    freeze
  end

  def register_user(email:, password:)
    payload = {
      email: email.strip.downcase,
      password: password,
    }
    validate_email(payload)
      .then { |e| validate_password_length(e) }
      .then { |e| insert_user(e) }
  end

  private

  def validate_email(payload)
    if payload[:email] =~ /.+@.+\..+/
      Result.success(payload)
    else
      Result.fail({ email: "must look like an email" }, payload)
    end
  end

  def validate_password_length(payload)
    if payload[:password].length >= MIN_PASSWORD_LENGTH
      Result.success(payload)
    else
      Result.fail(
        { password: "must be at least #{MIN_PASSWORD_LENGTH} characters" },
        payload,
      )
    end
  end

  def insert_user(payload)
    user = User.new(payload)
    @user_repo.insert(user)
  end
end
