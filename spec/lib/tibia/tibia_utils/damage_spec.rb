# frozen_string_literal: true

require 'rspec'
require 'json'

require_relative '../../../fixtures/lib/tibia_utils/damage_data_fixtures'
require_relative '../../../mock/embed_mock'
require_relative '../../../../lib/exceptions'
require_relative '../../../../lib/tibia/tibia_utils/damage'

SERVER_LOG_FILE_PATH = "#{Dir.pwd}/spec/fixtures/games/tibia/server_log.txt"

describe TibiaUtils::Damage do
  before do
    @file_content = File.open(SERVER_LOG_FILE_PATH).read
  end

  context 'with a valid server log' do
    describe '#analyze_damage_taken' do
      it 'should return a hash with the expected value when the player_name IS NOT "you"' do
        result = TibiaUtils::Damage.analyze_damage_taken('First Player', @file_content)

        expect(result).to eql({ 'arachnophobica' => 1579, 'crazed summer rearguard' => 16_062,
                                'crazed summer vanguard' => 5277, 'insane siren' => 3577 })
      end

      it 'should return a hash with the expected value when the player_name IS "you"' do
        result = TibiaUtils::Damage.analyze_damage_taken('You', @file_content)

        expect(result).to eql({ 'boogy' => 259,
                                'crazed summer rearguard' => 367,
                                'dark faun' => 246,
                                'insane siren' => 143,
                                'nomad' => 64,
                                'nymph' => 153,
                                'swan maiden' => 90,
                                'frost giantess' => 28,
                                'own attacks' => 15 })
      end

      it 'should return a hash with the expected value when the player_name IS NOT "you"' do
        result = TibiaUtils::Damage.analyze_damage_taken('First Player', TibiaUtilsDamageDataFixtures.server_log_message)

        expect(result).to eql('azed summer vanguard' => 196,
                              'crazed summer rearguard' => 717,
                              'crazed summer vanguard' => 994)
      end
    end
  end
end
