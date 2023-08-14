# frozen_string_literal: true

require 'discordrb'

if ENV['BOT_ENV'] == 'development'
  require 'dotenv'
  Dotenv.load
end
require_relative 'commands/tibia'
require_relative 'commands/utilities'

@bot = Discordrb::Commands::CommandBot.new(token: ENV.fetch('DISCORD_TOKEN', nil),
                                           client_id: ENV.fetch('DISCORD_CLIENT_ID', nil),
                                           prefix: ENV.fetch('DISCORD_PREFIX', nil))

@bot.message(with_text: 'ping') do |event|
  event.send_message('Pong')
end

@bot.include! Commands::Tibia
@bot.include! Commands::Utilities
@bot.run
