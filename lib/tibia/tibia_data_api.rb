# frozen_string_literal: true

require 'httparty'
if %w[development test].include? ENV['BOT_ENV']
  require 'dotenv'
  Dotenv.load
end

# TibiaData API Consumer
class TibiaDataApi
  include HTTParty
  base_uri 'https://api.tibiadata.com/v3'

  def initialize(world: ENV.fetch('TIBIA_WORLD', nil), guild: ENV.fetch('TIBIA_GUILD', nil))
    @world = world
    @guild = guild
  end

  def world_data
    self.class.get("/world/#{@world}")
  end

  def guild_data
    self.class.get("/guild/#{normalized_guild_name}")
  end

  def normalized_guild_name
    @guild.gsub(' ', '+')
  end
end
