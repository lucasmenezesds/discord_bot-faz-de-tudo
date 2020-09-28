# frozen_string_literal: true

require_relative '../../exceptions'
require_relative '../../generic_utils'
require_relative '../tibia_message_helper'

# Utils for Tibia Module
module TibiaUtils
  # Module Related to Loot Data
  module Loot
    include ::CustomExceptions
    include GenericUtils

    def self.parse_loot_message(loot_msg)
      loot_msg_as_array = loot_msg.split("\n")

      separated_info = loot_msg_as_array.each_slice(6).to_a
      info_hash = {}

      parsed_info = separated_info.map do |info|
        player_hash = {}

        info.each do |elem|
          key_value = elem.strip.split(':', 2)

          if key_value[1].nil?
            player_hash['name'] = key_value[0]
          else
            player_hash[key_value[0]] = key_value[1].strip.gsub(',', '')
          end
        end

        player_hash
      end

      info_hash['hunt_info'] = parsed_info.shift
      info_hash['players_balance'] = parsed_info

      info_hash
    end

    def self.calculate_each_players_balance(players_data, share_per_player)
      players_balance = {}
      players_debts = {}

      players_data.each do |player|
        player_balance = player['Balance'].to_i
        normalized_player_name = player['name']

        fix_player_balance = if player_balance.negative?
                               player_balance.abs + share_per_player
                             else
                               player_balance - share_per_player
                             end

        if player_balance < share_per_player
          players_balance[normalized_player_name] = fix_player_balance
        else
          players_debts[normalized_player_name] = fix_player_balance
        end
      end

      [players_balance, players_debts]
    end

    def self.centralize_payments(players_debts)
      final_list = []

      main_payer = players_debts.max_by { |_key, value| value }

      players_debts.each do |player, value|
        next if player == main_payer[0]

        final_list << { 'from' => player, 'to' => main_payer[0], 'amount' => value }
      end

      final_list
    end

    def self.share_hunt_profit(parsed_loot)
      players_data = parsed_loot['players_balance']
      hunt_data = parsed_loot['hunt_info']

      final_hash = {}
      final_hash['hunt_session'] = hunt_data['Session data']
      final_hash['number_of_players'] = players_data.size

      share_per_player = hunt_data['Balance'].to_i / final_hash['number_of_players']
      final_hash['share_per_player'] = GenericUtils.prettify_number(share_per_player)
      players_amount = calculate_each_players_balance(players_data, share_per_player)
      players_balance = players_amount[0]

      final_hash['amount_to_transfer'] = players_balance
      final_hash['centralizing_payments'] = centralize_payments(players_amount[1])

      final_hash
    end

    def self.valid_loot_message?(parsed_loot)
      parsed_loot_keys_list = %w[hunt_info players_balance]
      hunt_info_keys_list = ['Session data', 'Session', 'Loot Type', 'Loot', 'Supplies', 'Balance']
      players_balance_keys_list = %w[Balance Damage Healing Loot Supplies name]

      hunt_info_keys_validation = false
      players_balance_keys_validation = false

      if parsed_loot.is_a? Hash
        parsed_loot_keys_validation = parsed_loot_keys_list.all? { |current_key| parsed_loot.key? current_key }
        parsed_loot_values_validation = parsed_loot['hunt_info'].is_a?(Hash) && parsed_loot['players_balance'].is_a?(Array)

        if parsed_loot_keys_validation && parsed_loot_values_validation
          hunt_info_keys_validation = hunt_info_keys_list.all? do |current_key|
            parsed_loot['hunt_info'].key? current_key
          end

          all_valid = true

          parsed_loot['players_balance'].each do |player_balance|
            players_balance_keys_validation = players_balance_keys_list.all? { |current_key| player_balance.key? current_key }
            all_valid = false unless players_balance_keys_validation
          end

          players_balance_keys_validation = all_valid
        end
      end

      (hunt_info_keys_validation && players_balance_keys_validation)
    end

    def self.calculate_loot_for_players(loot_message)
      parsed_loot = parse_loot_message(loot_message)

      return share_hunt_profit(parsed_loot) if TibiaUtils::Loot.valid_loot_message?(parsed_loot)

      raise DataIsntInCorrectFormat, 'Loot Message is not correct, please check'
    end

    def self.loot_for_players(embed, loot_msg)
      loot_for_players = TibiaUtils::Loot.calculate_loot_for_players(loot_msg)
      TibiaMessageHelper.build_embed_message_for_loot(embed, loot_for_players)
    end
  end
end
