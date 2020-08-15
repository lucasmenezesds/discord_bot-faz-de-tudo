source 'https://rubygems.org'

gem 'discordrb', git: "https://github.com/lucasmenezesds/discordrb.git", branch: 'hotfix/voice_websocket'
gem 'httparty', '~> 0.18.0'
gem "lita-heroku-keepalive"

group :development do
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  # gem 'rerun'
  gem 'rubocop'
  gem 'pry'
  gem 'simplecov', require: false
end

group :test, :development do
  gem 'rspec'
  gem 'dotenv', '~> 2.4'
end