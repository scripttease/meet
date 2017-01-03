# frozen_string_literal: true
require "config/config"
require "securerandom"
require "bcrypt"

class SaltedPassword
  attr_reader :hash, :salt

  def self.create(password)
    salt = SecureRandom.base64.slice(0, 6)
    hash = BCrypt::Password.create(
      salt + password,
      cost: MeetConfig.bcrypt_cost,
    )
    new(hash: hash, salt: salt)
  end

  def self.from_digest(digest)
    hash, salt = digest.split(":::")
    new(hash: hash, salt: salt)
  end

  def initialize(hash:, salt:)
    @hash = hash
    @salt = salt
  end

  def to_digest
    "#{hash}:::#{salt}"
  end

  def matching_password?(candidate_password)
    BCrypt::Password.new(hash) == (salt + candidate_password)
  end
end
