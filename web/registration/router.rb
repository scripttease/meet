# frozen_string_literal: true

require "web/base_router"
require "lib/registration/controller"

class RegistrationRouter < BaseRouter

  def initialize(controller: RegistrationController.new)
    super(app)
    @controller = controller
  end

  get "/" do
    "Hello from the registration router!"
  end

  post "/" do
    res = @controller.register_user(
      email: params["email"],
      password: params["password"],
    )
    if res.successful?
      status 201
      "User created! #{res.payload.inspect}"
    else
      status 400
      "User unable to be created. #{res.errors.inspect}"
    end
  end
end
