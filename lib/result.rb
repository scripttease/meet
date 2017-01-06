# frozen_string_literal: true

#
# A generic indicator of whether an operation has succeeded or failed.
# Contains optional payload and errors.
#
# The `#then` method can be used to chain transformations...
# It's an Either monad! :D
#
module Result
  attr_reader :payload, :errors

  def self.success(payload = nil)
    Success.new(payload)
  end

  def self.fail(errors = nil, payload = nil)
    Fail.new(errors, payload)
  end
end

#
# Success type. `then` chains transformations
#
class Result::Success
  attr_reader :payload

  def initialize(payload)
    @payload = payload
    freeze
  end

  def successful?
    true
  end

  def then
    yield payload
  end
end

#
# Fail type. `then` does not chain transformations
#
class Result::Fail
  attr_reader :payload, :errors

  def initialize(errors, payload)
    @payload = payload
    @errors = errors
    freeze
  end

  def successful?
    false
  end

  def then
    self
  end
end
