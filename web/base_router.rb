# frozen_string_literal: true
require "sinatra/base"

class BaseRouter < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), "templates")
end
