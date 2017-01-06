# frozen_string_literal: true

require "lib/result"

#
# In test cases where nothing should be inserted we use a
# mock repo that fails the test when called
#
class MockExplodingRepo
  def insert(model)
    raise "Nothing should be inserted. \nInsert model: #{model.inspect}"
  end
end

#
# In test cases where something should be inserted, but we don't actually want
# the side effects we can just return the given model.
#
class MockIdentityRepo
  def insert(model)
    Result.success(model)
  end
end
