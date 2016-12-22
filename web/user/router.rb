# frozen_string_literal: true
require "web/base_router"

class UserRouter < BaseRouter
  get "/" do
    "Hello from the user router!"
  end
end
