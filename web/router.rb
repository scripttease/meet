# frozen_string_literal: true
require "sinatra/base"

require "web/static_page/router"
require "web/registration/router"

MeetRouter = Rack::URLMap.new(
  "/users" => RegistrationRouter,
  "/" => StaticPageRouter,
)
