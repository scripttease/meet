# frozen_string_literal: true

class AppConfig
  def initialize(env = ENV["RACK_ENV"])
    @env = env
  end

  def postgres_db_url
    case @env
    when "development"
      "postgres://postgres@database/meet_dev"
    when "test"
      ENV.fetch("DATABASE_POSTGRES_URL",
                "postgres://postgres@database/meet_test")
    else
      ENV.fetch("DATABASE_POSTGRES_URL")
    end
  end

  def bcrypt_cost
    case @env
    when "development", "test"
      1
    else
      10
    end
  end
end

MeetConfig = AppConfig.new
