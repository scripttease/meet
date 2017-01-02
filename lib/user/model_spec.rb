# frozen_string_literal: true

require "lib/user/model"

RSpec.describe User do

  it "is frozen" do
    a = User.new(email: "hello")
    expect(a).to be_frozen
  end

  describe ".new" do
    it "sets the properties" do
      a = User.new(email: "hello")
      expect(a.email).to eq("hello")
    end
  end

  describe ".with" do
    it "can be used to immutably modify properties" do
      user1 = User.new(id: 1, email: "hello")
      user2 = user1.with(id: 2)
      expect(user2.to_h).to eq(id: 2, email: "hello")
    end
  end

  describe "#properties" do
    it "returns an array of property names" do
      expect(User.properties).to eq([:id, :email])
    end
  end

  describe "#to_h" do
    it "returns all attributes as a hash" do
      a = User.new(email: "hello")
      expect(a.to_h).to eq(id: nil, email: "hello")
    end
  end

  describe "#==" do
    it "can have equal Users" do
      a = User.new(email: "hello")
      b = User.new(email: "hello")
      expect(a).to eq b
    end

    it "can have unequal Users" do
      a = User.new(email: "hello")
      b = User.new(email: "world")
      expect(a).not_to eq b
    end

    it "is equal for objects that hash to the same values" do
      a = User.new(email: "hello")
      b = { id: nil, email: "hello" }
      expect(a).to eq b
    end

    it "returns false for un-hashable objects" do
      a = User.new(email: "hello")
      b = "something"
      expect(a).not_to eq b
    end
  end
end
