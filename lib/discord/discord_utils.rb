# frozen_string_literal: true

require 'httparty'
require_relative '../generic_utils'

# Class with some Discord Utils
class DiscordUtils
  ATTACHMENTS_PATH = 'fixtures/discord_attachment'

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

  def download_attachment_file(attachment_url, filename)
    file_path = "#{ATTACHMENTS_PATH}/#{filename}"
    File.open(file_path, 'w') do |file|
      file.binmode
      HTTParty.get(attachment_url, stream_body: true, follow_redirects: true) do |fragment|
        file.write(fragment)
      end
    end
  end

  def self.delete_downloaded_attachments
    download_attachment_path = "#{Dir.pwd}/fixtures/discord_attachment/"
    GenericUtils.delete_all_files(download_attachment_path)
  end

  def get_channel_message_content(channel_name:)
    message = get_channel_messages(channel_name: channel_name, number_of_messages: 1).first

    if message.instance_of?(Discordrb::Message) && message.attachments.empty?
      message.content
    else
      attachment_data = message.attachments.first
      download_attachment_file(attachment_data.url, attachment_data.filename)
      GenericUtils.file_content("#{ATTACHMENTS_PATH}/#{attachment_data.filename}")
      # DiscordUtils.delete_downloaded_attachments

    end
  end
end
