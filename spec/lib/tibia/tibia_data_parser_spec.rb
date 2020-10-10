# frozen_string_literal: true

require 'rspec'
require 'json'

require_relative '../../../lib/tibia/tibia_data_parser.rb'
require_relative '../../fixtures/lib/tibia/tibia_data_fixtures.rb'
require_relative '../../../lib/exceptions'

describe TibiaDataParser do
  let(:parsed_world_json) do
    File.open('spec/fixtures/lib/tibia/word_data.json') do |file|
      JSON.parse(file.read)
    end
  end

  # let(:parsed_guild_json) do
  #   File.open('spec/fixtures/lib/tibia/guild_data.json') do |file|
  #     JSON.parse(file.read)
  #   end
  # end

  context 'with a valid json object' do
    describe '#players_online' do
      it 'should return an array of players' do
        result = described_class.players_online(json_data: parsed_world_json)

        expect(result).to eql(TibiaDataFixtures.successful_players_data)
      end
    end

    # describe '#online_from_guild' do
    #   it 'should return an array of players' do
    #     result = described_class.online_from_guild(json_data: parsed_guild_json)
    #
    #     expect(result).to eql(TibiaDataFixtures.success_guild_array)
    #   end
    # end
  end

  context 'with a invalid json object' do
    describe '#players_online' do
      it 'should return an empty array for a nil value' do
        expect { described_class.players_online(json_data: nil) }
          .to raise_error(CustomExceptions::CouldntRetrieveResource, "I couldn't get the data from this world")
      end

      it 'should return an empty array for a json not having the key "world"' do
        expect { described_class.players_online(json_data: { test: [] }) }
          .to raise_error(CustomExceptions::CouldntRetrieveResource, "I couldn't get the data from this world")
      end

      it 'should return an empty array for a json not having the key "players_online" on the "world" key' do
        expect { described_class.players_online(json_data: { world: [] }) }
          .to raise_error(CustomExceptions::CouldntRetrieveResource, "I couldn't get the data from this world")
      end
    end

    describe '#online_from_guild' do
      it 'should return an empty array for a nil value' do
        result = described_class.online_from_guild(json_data: nil)
        expect(result).to eql([])
      end

      it 'should return an empty array for a json not having the key "guild"' do
        result = described_class.online_from_guild(json_data: { test: [] })
        expect(result).to eql([])
      end

      it 'should return an empty array for a json not having the key "members" on the "guild" key' do
        result = described_class.online_from_guild(json_data: { guild: {} })
        expect(result).to eql([])
      end

      it 'should return an empty array for a json on a nil value on "player" on the "guild/members" key' do
        result = described_class.online_from_guild(json_data: { guild: { members: [nil] } })
        expect(result).to eql([])
      end
    end
  end
end
