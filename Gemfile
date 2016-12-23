# frozen_string_literal: true
source "https://rubygems.org"

gem "sinatra", "~> 1.4"
gem "sequel", "~> 4.41"
gem "pg", "~> 0.19"

group :development, :test do
  gem "rspec"     # Test framework
  gem "rack-test" # Rack app test helpers
  gem "simplecov" # Coverage tracking tool

  # Reload app on each request in dev
  gem "shotgun"

  # Linter
  gem "rubocop"
end
