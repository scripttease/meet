# frozen_string_literal: true
require "sinatra/base"

require "web/static_page/router"
require "web/user/router"

MeetRouter = Rack::URLMap.new(
  "/users" => UserRouter,
  "/" => StaticPageRouter,
)
