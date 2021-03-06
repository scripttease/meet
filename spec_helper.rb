# frozen_string_literal: true

# Include project dir in load path
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Set env
ENV["RACK_ENV"] = "test"

# Track test coverage
require "simplecov"
if ENV["CIRCLE_ARTIFACTS"]
  dir = File.join(ENV["CIRCLE_ARTIFACTS"], "coverage")
  SimpleCov.coverage_dir(dir)
end
SimpleCov.start

require "database_cleaner"
DatabaseCleaner[:sequel].strategy = :transaction

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.backtrace_exclusion_patterns << /gems/

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "tmp/tests.txt"
  config.disable_monkey_patching!
  config.default_formatter = "doc" if config.files_to_run.one?
  config.order = :random
  Kernel.srand config.seed
end
