# frozen_string_literal: true

require "web/base_router"
require "lib/registration/controller"
require "lib/user/model"

class RegistrationRouter < BaseRouter

  def initialize(app = nil, controller: RegistrationController.new)
    super(app)
    @controller = controller
  end

  get "/" do
    @user = User.new
    erb :"registration/form"
  end

  post "/" do
    res = @controller.register_user(
      email: params["email"],
      password: params["password"],
    )
    if res.successful?
      status 201
      redirect "/"
    else
      status 400
      @user = User.new(res.payload)
      @errors = res.errors
      erb :"registration/form"
    end
  end
end
