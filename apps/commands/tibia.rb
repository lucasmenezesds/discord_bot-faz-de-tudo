# frozen_string_literal: true

require 'discordrb'
require_relative '../../lib/exceptions'
require_relative '../../lib/tibia/tibia_message_helper'
require_relative '../../lib/tibia/tibia_utils'


# rubocop:disable Style/RescueStandardError
module Commands
  # Tibia Commands
  module Tibia
    extend Discordrb::Commands::CommandContainer
    include CustomExceptions
    include TibiaUtils

    def self.who_is_online_command(event, world_name, table_type: 'custom')
      embed_fields, players_online = TibiaUtils.online_players_table(world_name, table_type: table_type)

      msg_color = TibiaMessageHelper.color_per_number(players_online)

      event.channel.send_embed do |embed|
        TibiaMessageHelper.build_embed_table(embed, embed_fields, msg_color, players_online, world_name)
      end
    end

    desc = "Show the number of Players Online on #{ENV['TIBIA_WORLD']} divided by a **CUSTOM** level's range"
    usage = "'#{ENV['DISCORD_PREFIX']}online' on a chat channel"
    command :online, { description: desc, usage: usage } do |event|
      who_is_online_command(event, ENV['TIBIA_WORLD'])

    rescue CouldntRetrieveResource => e
      event.channel.send_message e.message

    rescue => e
      puts e
      event.channel.send_message CustomExceptions::DEV_MESSED_UP_MESSAGE
    end

    desc = "Show the number of Players Online on the **SPECIFIED** world, divided by a **CUSTOM** level's range"
    usage = "'#{ENV['DISCORD_PREFIX']}online_on <WORLD NAME>' on a chat channel"
    command :online_on, { min_args: 1, description: desc, usage: usage } do |event, world_name|
      who_is_online_command(event, world_name)

    rescue CouldntRetrieveResource => e
      event.channel.send_message e.message
    rescue => e
      puts e
      event.channel.send_message CustomExceptions::DEV_MESSED_UP_MESSAGE
    end

    desc = "Show the number of Players Online on #{ENV['TIBIA_WORLD']} divided by level's range"
    usage = "'#{ENV['DISCORD_PREFIX']}online2' on a chat channel"
    command :online2, { description: desc, usage: usage } do |event|
      who_is_online_command(event, ENV['TIBIA_WORLD'], table_type: 'original')

    rescue CouldntRetrieveResource => e
      event.channel.send_message e.message
    rescue => e
      puts e
      event.channel.send_message CustomExceptions::DEV_MESSED_UP_MESSAGE
    end

    desc = "Show the number of Players Online on the **SPECIFIED** world, divided by level's range"
    usage = "'#{ENV['DISCORD_PREFIX']}online_on2 <WORLD NAME>' on a chat channel"
    command :online_on2, { min_args: 1, description: desc, usage: usage } do |event, world_name|
      who_is_online_command(event, world_name, table_type: 'original')

    rescue CouldntRetrieveResource => e
      event.channel.send_message e.message
    rescue => e
      puts e
      event.channel.send_message CustomExceptions::DEV_MESSED_UP_MESSAGE
    end

    desc = "Show the player's levels that you'll be able to share xp in a party"
    usage = "'#{ENV['DISCORD_PREFIX']}sharexp <150>'"
    command :sharexp, { description: desc, usage: usage } do |event, level|
      received_level = level.to_i
      min_level = (received_level * 0.6667).to_i
      max_level = (received_level * 1.5).to_i

      event.channel.send_embed do |embed|
        embed.title = "Level's Range"
        embed.description = "\n__Your Level__: **#{level}**\n"
        embed.add_field({ name: 'Min Level:', value: "**#{min_level}**" })
        embed.add_field({ name: 'Max Level:', value: "**#{max_level}**" })
      end
    end
  end
end
# rubocop:enable Style/RescueStandardError
