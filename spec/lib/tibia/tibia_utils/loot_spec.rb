# frozen_string_literal: true

require 'rspec'
require 'json'

require_relative '../../../../lib/tibia/tibia_utils/loot'
require_relative '../../../fixtures/lib/tibia/tibia_data_fixtures'
require_relative '../../../../lib/exceptions'
require_relative '../../../mock/embed_mock'

describe TibiaUtils::Loot do
  context 'with a valid loot message' do
    shared_examples 'for the following number of players' do |number_of_players|
      describe '#parse_loot_message' do
        it "should return the parsed loot message for #{number_of_players} players" do
          loot_msg = TibiaDataFixtures.send("loot_message_#{number_of_players}_players")

          info_hash = TibiaUtils::Loot.parse_loot_message(loot_msg)

          expect(info_hash).to eql(TibiaDataFixtures.send("parsed_loot_message_#{number_of_players}_players"))
        end
      end

      describe '#share_hunt_profit' do
        it "should return a hash with the expected values for #{number_of_players} players" do
          parsed_loot = TibiaDataFixtures.send("parsed_loot_message_#{number_of_players}_players")
          result = TibiaUtils::Loot.share_hunt_profit(parsed_loot)

          expect(result).to eql(TibiaDataFixtures.send("final_balance_for_#{number_of_players}_players"))
        end

        if number_of_players != 2
          it "should return a hash with the expected values for #{number_of_players} players MULTIPLE PAYMENTS" do
            parsed_loot = TibiaDataFixtures.send("parsed_loot_message_#{number_of_players}_players_with_multiple_payments")
            result = TibiaUtils::Loot.share_hunt_profit(parsed_loot)

            expect(result).to eql(TibiaDataFixtures.send("final_balance_for_#{number_of_players}_players_with_multiple_payments"))
          end
        end
      end
    end

    include_examples 'for the following number of players', 2
    include_examples 'for the following number of players', 3
    include_examples 'for the following number of players', 4

    describe '#valid_loot_message?' do
      it 'should return true' do
        parsed_loot = TibiaDataFixtures.parsed_loot_message_4_players

        result = TibiaUtils::Loot.valid_loot_message?(parsed_loot)

        expect(result).to be_truthy
      end
    end

    describe '#calculate_loot_for_players' do
      it 'should return a hash having the final data for building the message' do
        loot_message = TibiaDataFixtures.loot_message_4_players

        result = TibiaUtils::Loot.calculate_loot_for_players(loot_message)
        expect(result).to eq TibiaDataFixtures.final_balance_for_4_players
      end
    end

    describe '#loot_for_players' do
      it 'should return call each embed message method once' do
        loot_message = TibiaDataFixtures.loot_message_4_players

        @embed_mock = DiscordMock::Embed.new

        allow(@embed_mock).to receive('title=').and_return('expected_title')
        allow(@embed_mock).to receive('description=').and_return('expected_description')
        allow(@embed_mock).to receive(:add_field).and_return('expected_embed')

        TibiaUtils::Loot.loot_for_players(@embed_mock, loot_message)

        expect(@embed_mock).to have_received('title=').once
        expect(@embed_mock).to have_received('description=').once
        expect(@embed_mock).to have_received(:add_field).once
      end
    end
  end

  context 'with a invalid loot message' do
    describe '#valid_loot_message?' do
      it 'should return false when the loot message have a missing/wrong key on players_balance' do
        parsed_loot = TibiaDataFixtures.invalid_parsed_loot_message_players_balance

        result = TibiaUtils::Loot.valid_loot_message?(parsed_loot)

        expect(result).to be_falsey
      end

      it 'should return false when the loot message have a missing key on hunt_info' do
        parsed_loot = TibiaDataFixtures.invalid_parsed_loot_message_hunt_info

        result = TibiaUtils::Loot.valid_loot_message?(parsed_loot)

        expect(result).to be_falsey
      end

      it 'should return false when the loot message is wrong' do
        result = TibiaUtils::Loot.valid_loot_message?('[x:y]')

        expect(result).to be_falsey
      end
    end

    describe '#calculate_loot_for_players' do
      it 'should raise the DataIsntInCorrectFormat error' do
        expect { TibiaUtils::Loot.calculate_loot_for_players('') }
          .to raise_error(CustomExceptions::DataIsntInCorrectFormat, 'Loot Message is not correct, please check')
      end
    end
  end
end
