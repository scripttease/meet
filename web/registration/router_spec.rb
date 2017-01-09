# frozen_string_literal: true

require "rack/test"
require "web/registration/router"
require "lib/registration/controller"
require "lib/user/model"
require "lib/result"

RSpec.describe RegistrationRouter do
  include Rack::Test::Methods

  before { @app = RegistrationRouter.new }

  attr_reader :app

  describe "GET /" do
    it "responds" do
      get "/"
      expect(last_response.status).to eq 200
    end
  end

  describe "POST /" do
    def email
      "amy@alice.dee"
    end

    def password
      "hunter7"
    end

    def inject_ctrl(result)
      ctrl = instance_double(
        RegistrationController,
        register_user: result,
      )
      @app = RegistrationRouter.new(nil, controller: ctrl)
      ctrl
    end

    it "registers a user via the UserController" do
      res = Result.success(User.new(email: email, password: password))
      ctrl = inject_ctrl(res)
      expect(ctrl).to receive(:register_user)
        .with(email: email, password: password)
      post("/", email: email, password: password)
      expect(last_response.status).to eq 302
    end

    it "displays errors and re-fills the form when registration fails" do
      errors = { email: "is too short" }
      payload = { email: "tim@web.net" }
      inject_ctrl(Result.fail(errors, payload))
      post("/", email: email, password: password)
      expect(last_response.status).to eq 400
      expect(last_response.body).to include("tim@web.net")
    end
  end
end
