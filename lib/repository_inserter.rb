# frozen_string_literal: true

require "lib/result"

class RepositoryInserter
  def initialize(dataset)
    @dataset = dataset
  end

  def insert(model)
    attrs = HashExtra.without_blank(model.to_h)
    id = insert_into_database!(attrs)
    attrs[:id] = id
    Result.success(payload: model.class.new(attrs))
  rescue Sequel::NotNullConstraintViolation => e
    handle_null_contraint_error(e)
  end

  private

  def insert_into_database!(attrs)
    @dataset.insert(attrs)
  end

  def handle_null_contraint_error(error)
    name = /null value in column "([^"]+)"/.match(error.message)[1]
    Result.fail(errors: { name => ["must be present"] })
  end
end
