# frozen_string_literal: true

require 'discordrb'
require_relative '../../lib/discord/discord_utils'
require_relative '../../lib/exceptions'
require_relative '../../lib/tibia/tibia_message_helper'
require_relative '../../lib/tibia/tibia_utils/tibia_utils'

# rubocop:disable Style/RescueStandardError
module Commands
  # Tibia Commands
  module Tibia
    extend Discordrb::Commands::CommandContainer
    include CustomExceptions
    include TibiaUtils

    ## ONLINE COMMANDS ##

    def self.who_is_online_command(event, world_name, table_type: 'custom')
      embed_fields, players_online = TibiaUtils::Online.online_players_table(world_name, table_type: table_type)

      msg_color = TibiaMessageHelper.color_per_number(players_online)

      event.channel.send_embed do |embed|
        TibiaMessageHelper.build_embed_table(embed, embed_fields, msg_color, players_online, world_name)
      end
    end

    desc = "Show the number of Players Online on #{ENV.fetch('TIBIA_WORLD', nil)} divided by a **CUSTOM** level's range"
    usage = "'#{ENV.fetch('DISCORD_PREFIX', nil)}online' on a chat channel"
    command :online, { description: desc, usage: usage } do |event, word_name = nil|
      word_name = ENV.fetch('TIBIA_WORLD', nil) if word_name.nil?
      who_is_online_command(event, word_name)
    rescue CouldntRetrieveResource => e
      event.channel.send_message e.message
    rescue => e
      puts e
      event.channel.send_message CustomExceptions::DEV_MESSED_UP_MESSAGE
    end

    desc = "Show the number of Players Online on #{ENV.fetch('TIBIA_WORLD', nil)} divided by level's range"
    usage = "'#{ENV.fetch('DISCORD_PREFIX', nil)}online2' on a chat channel"
    command :online2, { description: desc, usage: usage } do |event, world_name = nil|
      world_name = ENV.fetch('TIBIA_WORLD', nil) if world_name.nil?
      who_is_online_command(event, world_name, table_type: 'original')
    rescue CouldntRetrieveResource => e
      event.channel.send_message e.message
    rescue => e
      puts e
      event.channel.send_message CustomExceptions::DEV_MESSED_UP_MESSAGE
    end

    ## END ONLINE COMMANDS ##

    ## SHARE XP COMMAND ##
    desc = "Show the player's levels that you'll be able to share xp in a party"
    usage = "'#{ENV.fetch('DISCORD_PREFIX', nil)}sharexp <150>'"
    command :sharexp, { description: desc, usage: usage } do |event, level|
      received_level = level.to_i
      min_level = (received_level * 0.6667).to_i
      max_level = (received_level * 1.5).to_i

      event.channel.send_embed do |embed|
        embed.title = "Level's Range"
        embed.description = "\n__Your Level__: **#{level}**\n"
        embed.add_field(name: 'Min Level:', value: "**#{min_level}**")
        embed.add_field(name: 'Max Level:', value: "**#{max_level}**")
      end
    end

    ## LOOT COMMAND ##
    desc = "Split the loot value between the party's members from the 'loots' channel [Last message is default]"
    usage = "'#{ENV.fetch('DISCORD_PREFIX', nil)}loot [2]'"
    command :loot, { description: desc, usage: usage } do |event, number_of_messages = 1|
      @disc_utils = DiscordUtils.new(bot: event.bot)

      loots_channel_messages = @disc_utils.get_channel_messages(channel_name: 'loots', number_of_messages: number_of_messages)

      reversed_channel_messages = loots_channel_messages.reverse
      messages_list_size = loots_channel_messages.size

      reversed_channel_messages.each_with_index do |channel_msg, index|
        event.channel.send_embed do |embed|
          TibiaUtils::Loot.loot_for_players(embed, channel_msg.content)
        end
      rescue DataIsntInCorrectFormat => e
        event.channel.send_message "#{e.message} the #{messages_list_size - index}-nth last message!"
      end

      event.channel.send_message '**All Done!**'
    rescue CouldntRetrieveResource => e
      event.channel.send_message e.message
    rescue => e
      puts e
      event.channel.send_message CustomExceptions::DEV_MESSED_UP_MESSAGE
    end
  end
end
# rubocop:enable Style/RescueStandardError
