# frozen_string_literal: true

require_relative '../config/database'

Sequel.extension :migration

Sequel::Migrator.run(DB, 'db/migrate')

puts 'Migrations finished.'
