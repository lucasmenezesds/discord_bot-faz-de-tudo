# frozen_string_literal: true

require 'httparty'
if %w[development test].include? ENV['BOT_ENV']
  require 'dotenv'
  Dotenv.load
end

# TibiaData API Consumer
class TibiaDataApi
  include HTTParty
  base_uri 'https://api.tibiadata.com/v2'

  def initialize(world: ENV['TIBIA_WORLD'], guild: ENV['TIBIA_GUILD'])
    @world = world
    @guild = guild
  end

  def world_data
    self.class.get("/world/#{@world}.json")
  end

  def guild_data
    self.class.get("/guild/#{normalized_guild_name}.json")
  end

  def normalized_guild_name
    @guild.gsub(' ', '+')
  end
end
