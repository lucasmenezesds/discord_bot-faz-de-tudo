# frozen_string_literal: true

require 'sequel'
require 'sqlite3'

ENVIRONMENT = ENV['RACK_ENV'] || 'development'

case ENVIRONMENT
when 'development'
  DB_PATH = 'database_volume/discord_bot_development.db'
  SQLite3::Database.new(DB_PATH) unless File.exist?(DB_PATH)
  DB = Sequel.sqlite(DB_PATH)
when 'test'
  DB_PATH = 'database_volume/discord_bot_test.db'
  SQLite3::Database.new(DB_PATH) unless File.exist?(DB_PATH)
  DB = Sequel.sqlite(DB_PATH)
when 'production'
  DB = Sequel.connect("postgres://#{ENV['POSTGRES_USER']}:#{ENV['POSTGRES_PASSWORD']}@#{ENV['POSTGRES_HOST']}/#{ENV['POSTGRES_DB_NAME']}")
  # DB = Sequel.sqlite('db/discord_bot_production.db')
else
  raise "Unsupported environment: #{ENVIRONMENT}"
end
