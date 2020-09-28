# frozen_string_literal: true

# Message Helper for Tibia's related stuffs
module TibiaMessageHelper
  def self.color_per_number(players_online)
    if players_online > 700
      '#f1948a'
    elsif players_online > 250
      '#3498db'
    else
      '#48c9b0'
    end
  end

  def self.normalize_player_name(received_name)
    received_name.gsub('(Leader)', '').strip
  end

  def self.build_embed_table(embed, embed_fields, msg_color, players_online, world_name)
    final_table = embed_fields.fetch(:final_table, '')
    highlight_text = embed_fields.fetch(:highlight_text, '')
    embed.title = "Players on #{world_name}"
    embed.color = msg_color
    embed.description = "\n__Total of Players__: **#{players_online}**\n"
    embed.add_field({ name: 'Levels of the Players', value: "```#{final_table}```" })
    embed.add_field({ name: "Our Level's Range", value: "```#{highlight_text}```" })
  end

  def self.build_embed_message_for_loot(embed, loot_message)
    profit = loot_message.fetch('share_per_player', '???')
    hunt_session = loot_message.fetch('hunt_session', '???')
    amount_to_transfer = loot_message.fetch('amount_to_transfer', {})
    centralizing_payments = loot_message.fetch('centralizing_payments', [])
    transfer_message = ''
    debt_message = "\n\n"

    embed.title = "Party's Loot"
    embed.description = "\n**HUNT**: #{hunt_session}\n\n**Profit per Player**: #{profit}\n\n"

    amount_to_transfer.each do |player, amount|
      transfer_message += "```Transfer #{amount} to #{normalize_player_name(player)}```\n"
    end

    centralizing_payments.each do |player_data|
      from = normalize_player_name(player_data.fetch('from', '???'))
      to = normalize_player_name(player_data.fetch('to', '???'))
      amount = player_data.fetch('amount', 0)

      debt_message += "**#{from}** You Should Transfer the Extra Amount\n\n"
      debt_message += "```Transfer #{amount} to #{to}```\n"
    end

    embed.add_field({ name: 'Transfers', value: transfer_message })

    embed.add_field({ name: 'Debts', value: debt_message }) unless centralizing_payments.empty?
  end
end
