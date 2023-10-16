source 'https://rubygems.org'
ruby '3.2.2'

gem 'discordrb', '~> 3.5'
gem 'httparty', '~> 0.21.0'
gem 'rake', '~> 13.0', '>= 13.0.6'
gem 'sequel', '~> 5.73'
gem 'sqlite3', '~> 1.6', '>= 1.6.7'

group :development do
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-sequel', require: false
  gem 'simplecov', require: false
end

group :test, :development do
  gem 'dotenv', '~> 2.8'
  gem 'rspec'
  gem 'debug'
end