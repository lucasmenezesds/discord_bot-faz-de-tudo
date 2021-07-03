# frozen_string_literal: true

require_relative '../../discord/discord_utils'
require_relative '../../exceptions'
require_relative '../../generic_utils'
require_relative '../tibia_message_helper'

# ############
# DISCLAIMER #
# ############

# This feature was started to be develop before CipSoft had announced the implementation of this feature in-game,
# although since I had developed this part, so I kept it here just to show the way I though about the 'solution'.
# There is no command on set.

# #####

# Utils for Tibia Module
module TibiaUtils
  # Module Related to Damage Data
  module Damage
    include ::CustomExceptions

    def self.filter_player_damage_messages(player_name_separator, logs)
      raise DataIsNotOnTheExpectedFormat(method: 'filter_player_damage') if logs.nil?

      split_logs = logs.gsub("\r", '').split("\n")

      damage_logs = []
      split_logs.each do |log_message|
        normalized_log_message = log_message.downcase
        damage_logs << normalized_log_message.gsub('.', '').strip if normalized_log_message.include? player_name_separator
      end
      damage_logs
    end

    def self.parse_damage_giver_message(player_name_separator, log_msg)
      end_of_damage_splitter = if log_msg.include? 'mana'
                                 'mana'
                               elsif log_msg.include? 'hitpoints'
                                 'hitpoints'
                               else
                                 'hitpoint'
                               end

      damage_message = log_msg.split(player_name_separator)
      damage_amount, damage_giver_msg = damage_message.last.split(end_of_damage_splitter)

      damage_giver = if damage_giver_msg&.include?('due to your')
                       'own attacks'
                     elsif damage_giver_msg&.include? 'by an'
                       damage_giver_msg.split('by an').last.strip
                     else
                       damage_giver_msg.split('by a').last.strip
                     end

      [damage_amount, damage_giver]
    end

    def self.parse_damage_logs(player_name_separator, damage_logs)
      damage_taken = {}
      damage_logs.each do |log_msg|
        damage_amount, damage_giver = parse_damage_giver_message(player_name_separator, log_msg)

        if damage_taken[damage_giver].nil?
          damage_taken[damage_giver] = damage_amount.to_i unless damage_amount.nil?
        else
          damage_taken[damage_giver] += damage_amount.to_i unless damage_amount.nil?
        end
      end

      damage_taken
    end

    def self.analyze_damage_taken(player_name, logs_msg)
      player_name = player_name.downcase

      player_name_separator = if player_name == 'you'
                                'you lose'
                              else
                                "#{player_name} loses"
                              end

      damage_logs = filter_player_damage_messages(player_name_separator, logs_msg)
      parse_damage_logs(player_name_separator, damage_logs)
    end
  end
end
