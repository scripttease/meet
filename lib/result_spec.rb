# frozen_string_literal: true

require "lib/result"

RSpec.describe Result do

  it "can be successful" do
    res = Result.success("thingy")
    expect(res).to be_successful
    expect(res.payload).to eq("thingy")
  end

  it "can be unsuccessful" do
    res = Result.fail("some errors")
    expect(res).not_to be_successful
    expect(res.errors).to eq("some errors")
  end

  it "can be unsuccessful, with a payload" do
    res = Result.fail("some errors", "optional payload")
    expect(res).not_to be_successful
    expect(res.errors).to eq("some errors")
    expect(res.payload).to eq("optional payload")
  end

  describe "chaining of result returning functions" do

    it "chains for successes" do
      result =
        Result
        .success(1)
        .then { |e| Result.success(e + 1) }
        .then { |e| Result.success(e * 2) }
      expect(result).to be_successful
      expect(result.payload).to eq(4)
    end

    it "does not chain for fails" do
      result =
        Result
        .success(1)
        .then { |e| Result.success(e + 1) }
        .then { |e| Result.fail("an error", e) }
        .then { |_e| raise "This should never run" }
      expect(result).not_to be_successful
      expect(result.errors).to eq("an error")
      expect(result.payload).to eq(2)
    end
  end
end
