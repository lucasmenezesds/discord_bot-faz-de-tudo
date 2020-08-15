# frozen_string_literal: true

require 'rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError => e
  puts '=== Error ==='
  puts e.message
  puts '============='
end
