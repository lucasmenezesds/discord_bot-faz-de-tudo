# frozen_string_literal: true

require_relative '../exceptions'

# TibiaData API Parser
module TibiaDataParser
  include ::CustomExceptions

  def self.players_online(json_data:)
    players_online = json_data&.dig('worlds', 'world', 'players_online')
    players_list = json_data&.dig('worlds', 'world', 'online_players')

    raise CouldntRetrieveResource, "I couldn't get the data from this world" if players_online.nil? || players_list.nil?

    { players_online: players_online,
      players_list: players_list }
  end

  def self.online_from_guild(json_data:)
    final_list = []

    return final_list if !json_data || !json_data['guild'] || !json_data['guild']['members']

    json_data['guild']['members'].each do |rank|
      return final_list unless rank['characters']

      rank['characters'].each do |player|
        final_list << { 'name' => player['name'], 'level' => player['level'] } if player['status'] == 'online'
      end
    end

    final_list
  end
end
