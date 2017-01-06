# frozen_string_literal: true

require "rack/test"
require "web/static_page/router"

RSpec.describe StaticPageRouter do
  include Rack::Test::Methods

  def app
    StaticPageRouter
  end

  it "responds to get /" do
    get "/"
    expect(last_response.body).to include "Meet"
    expect(last_response.status).to eq 200
  end
end
