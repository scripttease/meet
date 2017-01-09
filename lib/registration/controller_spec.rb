# frozen_string_literal: true

require "test/repo_mock"
require "lib/registration/controller"

RSpec.describe "RegistrationController tests that hit the database" do
  around(:each) do |example|
    # Transactions result in an error after a failed insert.
    # Unsure how to fix this so using the slower deletion method for now :(
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.cleaning { example.run }
  end

  it "creates the user when given valid attrs" do
    controller = RegistrationController.new
    result = controller.register_user(
      email: "amy@alice.dee",
      password: "hunter7",
    )
    expect(result).to be_successful
    expect(result.payload.email).to eq("amy@alice.dee")
    inserted_user = UserRepository.new.find_by_email(result.payload.email)
    expect(inserted_user).to eq(result.payload)
    expect(inserted_user).not_to eq(nil)
  end
end

RSpec.describe RegistrationController do

  it "doesn't succeed if email is invalid" do
    controller = RegistrationController.new(user_repo: MockExplodingRepo.new)
    result = controller.register_user(
      email: "01645749367",
      password: "hunter7",
    )
    expect(result).not_to be_successful
    expect(result.errors[:email]).to eq("must look like an email")
  end

  it "doesn't succeed if password is short" do
    controller = RegistrationController.new(user_repo: MockExplodingRepo.new)
    result = controller.register_user(
      email: "  hello@world.com       ",
      password: "hunter",
    )
    expect(result).not_to be_successful
    expect(result.errors[:password]).to eq("must be at least 7 characters")
  end

  it "downcases and trims given valid emails" do
    controller = RegistrationController.new(user_repo: MockIdentityRepo.new)
    result = controller.register_user(
      email: "  HELLO@WORLD.COM       ",
      password: "hunter7",
    )
    expect(result).to be_successful
    expect(result.payload.email).to eq("hello@world.com")
  end
end
