# frozen_string_literal: true
source "https://rubygems.org"

# Web router library
gem "sinatra", "~> 1.4"

# Database ORM
gem "sequel", "~> 4.41"

# Postgres DB connector
gem "pg", "~> 0.19"

# Password hashing functions
gem "bcrypt", "~> 3.1"

group :development, :test do
  gem "rspec"            # Test framework
  gem "rack-test"        # Rack app test helpers
  gem "simplecov"        # Coverage tracking tool
  gem "database_cleaner" # Clear DB after stateful tests

  # Reload app on each request in dev
  gem "shotgun"

  # REPL and debugger
  gem "pry-byebug"

  # Linter
  gem "rubocop"
end
