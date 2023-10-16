# frozen_string_literal: true

require 'rake'

desc 'Database Related Tasks'
namespace :db do
  desc 'Run DB migrations'
  task :migrate do
    exec 'bundle exec ruby db/migrate.rb'
  end
end
