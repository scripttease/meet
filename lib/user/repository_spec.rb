# frozen_string_literal: true

require "lib/user/repository"

RSpec.describe UserRepository do
  around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  it "needs tests"
end
