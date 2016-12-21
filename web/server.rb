# frozen_string_literal: true
require "sinatra/base"

class MeetServer < Sinatra::Base
  get "/" do
    "Hello world!"
  end
end
