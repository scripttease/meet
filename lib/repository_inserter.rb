# frozen_string_literal: true

require "lib/result"

class RepositoryInserter
  def initialize(dataset)
    @dataset = dataset
  end

  def insert(model)
    persisted_attrs = try_insert_new_row!(model)
    new_model = model.class.new(persisted_attrs)
    Result.success(new_model)
  rescue Sequel::NotNullConstraintViolation => e
    handle_null_contraint_error(e)
  end

  private

  def try_insert_new_row!(model)
    attrs = HashExtra.without_blank(model.to_h)
    @dataset
      .returning(*model.class.properties)
      .insert(attrs)
      .first
  end

  def handle_null_contraint_error(error)
    name = /null value in column "([^"]+)"/.match(error.message)[1]
    Result.fail(name => ["must be present"])
  end
end
