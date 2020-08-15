# frozen_string_literal: true

require_relative '../exceptions'

# TibiaData API Parser
module TibiaDataParser
  include ::CustomExceptions

  def self.players_online(json_data:)
    if !json_data || !json_data['world'] || !json_data['world']['players_online'] || !json_data['world']['world_information']['players_online']
      raise CouldntRetrieveResource, "I couldn't get the data from this world"
    end

    { players_online: json_data['world']['world_information']['players_online'],
      players_list: json_data['world']['players_online'] }
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
