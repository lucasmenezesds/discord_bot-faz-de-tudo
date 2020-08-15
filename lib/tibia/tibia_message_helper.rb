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

  def self.build_embed_table(embed, embed_fields, msg_color, players_online, world_name)
    final_table = embed_fields.fetch(:final_table, '')
    highlight_text = embed_fields.fetch(:highlight_text, '')
    embed.title = "Players on #{world_name}"
    embed.color = msg_color
    embed.description = "\n__Total of Players__: **#{players_online}**\n"
    embed.add_field({ name: 'Levels of the Players', value: "```#{final_table}```" })
    embed.add_field({ name: "Our Level's Range", value: "```#{highlight_text}```" })
  end
end