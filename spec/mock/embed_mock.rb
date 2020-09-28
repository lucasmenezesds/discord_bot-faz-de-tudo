# frozen_string_literal: true

# Mock for Message Embed
module DiscordMock
  class Embed
    attr_accessor :title, :description

    def initialize(title = nil, description = nil, add_field = nil)
      @title = title
      @description = description
      @add_field = add_field
    end

    def add_field(hash)
      @add_field = hash
    end
  end
end
