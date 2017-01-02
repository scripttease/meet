# frozen_string_literal: true

require "lib/user/model"

RSpec.describe User do

  it "is frozen" do
    a = User.new(email: "hello")
    expect(a).to be_frozen
  end

  describe "#to_h" do
    it "returns all attributes as a hash" do
      a = User.new(email: "hello")
      expect(a.to_h).to eq(email: "hello")
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

    it "returns false for un-hashable objects" do
      a = User.new(email: "hello")
      b = "something"
      expect(a).not_to eq b
    end
  end
end
