# frozen_string_literal: true

require 'discordrb'
module Commands
  # Commands Utils
  module Utilities
    extend Discordrb::Commands::CommandContainer

    # @admin_roles = []

    command :my_id do |event|
      return event.respond 'Just the Owner can use this command' unless event.user.owner?

      event.user.id
    end

    desc = 'Deletes X amount of messages from the channel'
    usage = "#{ENV['DISCORD_BOT_PREFIX']}prune <number>"
    command :prune, description: desc, usage: usage do |event, amount|
      return event.respond 'Just the Owner can use this command' unless event.user.owner?

      amount = amount.to_i
      return 'You can only delete between 1 and 100 messages!' if amount > 100

      event.channel.prune amount, true
      event.respond "Done pruning #{amount} messages 💥"
    end
  end
end
