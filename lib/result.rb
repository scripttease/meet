# frozen_string_literal: true
#
# A generic indicator of whether an operation has succeeded or failed.
# Contains optional payload and errors.
#
class Result
  attr_reader :payload, :errors

  def self.success(payload: nil)
    new(successful: true, payload: payload)
  end

  def self.fail(errors: nil, payload: nil)
    new(successful: false, errors: errors, payload: payload)
  end

  def initialize(successful:, payload: nil, errors: nil)
    @successful = successful
    @payload = payload
    @errors = errors
    freeze
  end

  def successful?
    @successful
  end
end
