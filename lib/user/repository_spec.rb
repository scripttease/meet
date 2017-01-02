# frozen_string_literal: true

require "lib/user/repository"
require "lib/user/model"
require "lib/result"

RSpec.describe UserRepository do
  around(:each) do |example|
    # Transactions result in an error after a failed insert.
    # Unsure how to fix this so using the slower deletion method for now :(
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.cleaning { example.run }
  end

  describe "#insert" do
    it "persists the user in the DB if valid" do
      expect(DB[:users].count).to eq 0
      user_to_insert = User.new(email: "strongbad@email.games")
      result = UserRepository.new.insert(user_to_insert)
      expect(DB[:users].count).to eq 1
      expect(result).to be_successful
      expect(result.payload).to be_a(User)
      expect(result.payload.id).not_to be_nil
      expect(result.payload.email).to eq("strongbad@email.games")
    end

    it "returns an error result if unsuccessful" do
      expect(DB[:users].count).to eq 0
      result = UserRepository.new.insert(User.new)
      expect(DB[:users].count).to eq 0
      expect(result).not_to be_successful
      expect(result.payload).to be_nil
      expect(result.errors).to eq("email" => ["must be present"])
    end
  end

  describe "#find_by_email" do
    it "finds an existing user" do
      email = "information@super.highway"
      DB[:users].insert(email: email)
      user = UserRepository.new.find_by_email(email)
      expect(user).to be_a(User)
      expect(user.id).not_to be_nil
      expect(user.email).to eq(email)
    end

    it "returns nil when there is no user with that email" do
      expect(UserRepository.new.find_by_email("a@dee.com")).to be_nil
    end
  end

  describe "#find_by_id" do
    it "finds an existing user" do
      email = "information@super.highway"
      DB[:users].insert(email: email)
      id = DB[:users].first[:id]
      user = UserRepository.new.find_by_id(id)
      expect(user).to be_a(User)
      expect(user.id).to eq(id)
      expect(user.email).to eq(email)
    end

    it "returns nil when there is no user with that email" do
      expect(UserRepository.new.find_by_id(123)).to be_nil
    end
  end
end
