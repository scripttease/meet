# frozen_string_literal: true

require "sequel"
require "config/config"

DB = Sequel.connect(MeetConfig.postgres_db_url)
