# frozen_string_literal: true

require "lib/hash_extra"

RSpec.describe HashExtra do

  describe ".slice" do
    it "extras a subhash with the given whitelisted keys" do
      hash = { name: "Tom", age: "51", profession: "Baker" }
      expect(HashExtra.slice(hash, :name, :age)).to eq(name: "Tom", age: "51")
    end
  end

  describe ".without_blank" do
    it "removes blank KV pairs" do
      hash = { name: "Tom", age: " ", profession: nil }
      expect(HashExtra.without_blank(hash)).to eq(name: "Tom")
    end
  end
end
