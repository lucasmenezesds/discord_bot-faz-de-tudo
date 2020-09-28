# frozen_string_literal: true

require_relative '../../../fixtures/customized_settings'
require_relative '../../statistics/quantitative_freq_distribution'
require_relative '../../tibia/tibia_data_api'
require_relative '../../tibia/tibia_data_parser'
require_relative '../../generic_utils'

# Utils for Tibia Module
module TibiaUtils
  # Module Related to Online Data
  module Online
    # include GenericUtils
    def self.level_of_players_online(players_list:)
      players_levels = []
      players_list.each do |player|
        players_levels << player['level']
      end
      players_levels
    end

    def self.online_players_table(world = nil, table_type: 'custom')
      world_data = fetch_world_data(world)

      players_data = TibiaDataParser.players_online(json_data: world_data)
      players_online = players_data[:players_online]
      players_list = players_data[:players_list]
      levels_list = level_of_players_online(players_list: players_list)

      generated_table = generate_table(levels_list, table_type)

      final_data = { final_table: '', highlight_text: '' }

      generated_table.each do |data|
        final_data[:highlight_text] += "#{data[:class_text]} => #{data[:class_count]}" if data[:highlight]
        final_data[:final_table] += "#{data[:class_text]} => #{data[:class_count]}\n"
      end
      [final_data, players_online]
    end

    def self.generate_table(levels_list, table_type)
      qfd = QuantitativeFreqDistribution.new(data_array: levels_list)
      if table_type == 'custom'
        qfd.generate_custom_frequency_table(customized_limits: CustomizedSettings.tibia_level_frequency)
      else
        qfd.generate_frequency_table
      end
    end

    def self.fetch_world_data(world = nil)
      tibia_data_consumer = if world
                              TibiaDataApi.new(world: world)
                            else
                              TibiaDataApi.new
                            end

      tibia_data_consumer.world_data
    end

    def self.who_is_online_command(event, world_name, table_type: 'custom')
      embed_fields, players_online = TibiaUtils::Online.online_players_table(world_name, table_type: table_type)

      msg_color = TibiaMessageHelper.color_per_number(players_online)

      event.channel.send_embed do |embed|
        TibiaMessageHelper.build_embed_table(embed, embed_fields, msg_color, players_online, world_name)
      end
    end
  end
end
