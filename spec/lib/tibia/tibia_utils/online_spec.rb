# frozen_string_literal: true

require 'rspec'
require 'json'

require_relative '../../../../lib/tibia/tibia_utils/online'
require_relative '../../../../lib/tibia/tibia_data_api'
require_relative '../../../../lib/exceptions'
require_relative '../../../fixtures/lib/tibia_utils/online_data_fixtures'

describe TibiaUtils::Online do
  let(:parsed_world_json) do
    File.open('spec/fixtures/games/tibia/world_data.json') do |file|
      JSON.parse(file.read)
    end
  end

  context 'with successful payloads' do
    describe '#level_of_players_online' do
      it 'should return an array with the expected values' do
        players_list = TibiaUtilsOnlineDataFixtures.successful_players_data[:players_list]

        result = described_class.level_of_players_online(players_list: players_list)

        expect(result).to eql(TibiaUtilsOnlineDataFixtures.success_players_level_array)
      end
    end

    describe '#online_players_table' do
      it 'should return an array with the expected values for custom table and default world' do
        table_data = TibiaUtilsOnlineDataFixtures.custom_table_data

        data_api_mock = TibiaDataApi.new

        allow(TibiaDataApi).to receive(:new).and_return(data_api_mock)
        allow(data_api_mock).to receive(:world_data).and_return(parsed_world_json)

        result = described_class.online_players_table

        expect(result).to eql([table_data, 232])
      end

      it 'should return an array with the expected values for default table and custom world' do
        table_data = TibiaUtilsOnlineDataFixtures.table_data

        data_api_mock = TibiaDataApi.new

        allow(TibiaDataApi).to receive(:new).and_return(data_api_mock)
        allow(data_api_mock).to receive(:world_data).and_return(parsed_world_json)

        result = described_class.online_players_table('world1', table_type: 'normal')

        expect(result).to eql([table_data, 232])
      end
    end
  end
end
