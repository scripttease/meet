# frozen_string_literal: true

require "db/connection"
require "lib/repository_inserter"
require "lib/user/model"

class UserRepository

  class NotAUserError < RuntimeError
  end

  def insert(user)
    throw NotAUserError unless user.is_a?(User)
    RepositoryInserter.new(DB[:users]).insert(user)
  end

  def find_by_id(id)
    attrs = DB[:users].first(id: id)
    attrs && User.new(attrs)
  end

  def find_by_email(email)
    attrs = DB[:users].first(email: email)
    attrs && User.new(attrs)
  end
end
