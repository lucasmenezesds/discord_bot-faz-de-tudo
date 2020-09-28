# frozen_string_literal: true

# Class with some Discord Utils
class DiscordUtils
  def initialize(bot:)
    @bot = bot
  end

  def find_channel(channel_name)
    channels = @bot.find_channel(channel_name)
    return nil if channels.nil?

    channels.first
  end

  def get_channel_messages(channel_name:, number_of_messages: 1)
    channel = find_channel(channel_name)

    if channel
      channel.history(number_of_messages.to_i)
    else
      []
    end
  end
end
