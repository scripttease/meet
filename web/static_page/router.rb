# frozen_string_literal: true
require "web/base_router"

class StaticPageRouter < BaseRouter
  get "/" do
    erb :"page/home"
  end
end
