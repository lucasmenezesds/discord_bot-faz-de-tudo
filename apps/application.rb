# frozen_string_literal: true

require 'discordrb'
if ENV['BOT_ENV'] == 'development'
  require 'dotenv'
  Dotenv.load
end

bot = Discordrb::Commands::CommandBot.new(token: ENV['DISCORD_TOKEN'],
                                          client_id: ENV['DISCORD_CLIENT_ID'],
                                          prefix: ENV['DISCORD_PREFIX'])

bot.message(with_text: 'ping') do |event|
  event.send_message('Pong')
end

bot.run
