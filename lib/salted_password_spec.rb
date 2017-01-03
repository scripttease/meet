# frozen_string_literal: true
require "lib/salted_password"

RSpec.describe SaltedPassword do
  it "can be converted to and from a digest" do
    examples = {
      "123:::123" => { hash: "123", salt: "123" },
      "s:::12356" => { hash: "s", salt: "12356" },
      "blink182:::wevjbh" => { hash: "blink182", salt: "wevjbh" },
      "$h0wmeTHE_m0n3y!!:::yolo" => { hash: "$h0wmeTHE_m0n3y!!", salt: "yolo" },
    }
    examples.each do |digest, parts|
      pw = SaltedPassword.from_digest(digest)
      expect(pw.hash).to eq(parts[:hash])
      expect(pw.salt).to eq(parts[:salt])
      expect(pw.to_digest).to eq(digest)
    end
  end

  it "can be used to create a salted pw hash" do
    pw1 = SaltedPassword.create("hunter7")
    pw2 = SaltedPassword.create("hunter7")
    expect(pw1.hash).not_to eq(pw2.hash)
    expect(pw1.matching_password?("hunter7")).to be true
    expect(pw2.matching_password?("hunter7")).to be true
    expect(pw1.matching_password?("hi there")).to be false
    expect(pw2.matching_password?("hi there")).to be false
  end
end
