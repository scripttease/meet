# frozen_string_literal: true
require "db/connection"

RSpec.describe "cleaning of db in stateful tests" do
  around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  USERS = DB[:users]

  def insert_user!
    USERS.insert(email: "information@super.highway")
  end

  it "cleans table, check 1" do
    expect(USERS.count).to eq 0
    insert_user!
    expect(USERS.count).to eq 1
  end

  it "cleans table, check 2" do
    expect(USERS.count).to eq 0
    insert_user!
    expect(USERS.count).to eq 1
  end

  it "cleans table, check 3" do
    expect(USERS.count).to eq 0
    insert_user!
    expect(USERS.count).to eq 1
  end
end
