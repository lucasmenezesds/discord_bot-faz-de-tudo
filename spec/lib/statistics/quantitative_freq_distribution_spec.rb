# frozen_string_literal: true

require 'rspec'

require_relative '../../../lib/statistics/quantitative_freq_distribution'
require_relative '../../fixtures/lib/tibia_utils/online_data_fixtures'

describe QuantitativeFreqDistribution do
  context 'passing the correct parameters' do
    describe '#generate_frequency_table' do
      it 'should return the expected hash when the parameters are sent' do
        qfd = QuantitativeFreqDistribution.new(data_array: TibiaUtilsOnlineDataFixtures.players_levels_list)
        result = qfd.generate_frequency_table

        expect(result).to eq(TibiaUtilsOnlineDataFixtures.correct_quantitative_table_data)
      end
    end

    describe '#generate_custom_frequency_table' do
      it 'should return the expected hash when the parameters are sent' do
        qfd = QuantitativeFreqDistribution.new(data_array: TibiaUtilsOnlineDataFixtures.players_levels_list)
        result = qfd.generate_custom_frequency_table(customized_limits: TibiaUtilsOnlineDataFixtures.customized_limits)

        expect(result).to eq(TibiaUtilsOnlineDataFixtures.correct_customized_quantitative_table_data)
      end
    end

    describe '#amplitude' do
      it 'should return the expected value' do
        qfd = QuantitativeFreqDistribution.new(data_array: TibiaUtilsOnlineDataFixtures.players_levels_list)
        result = qfd.generate_custom_frequency_table(customized_limits: TibiaUtilsOnlineDataFixtures.customized_limits)

        expect(result).to eq(TibiaUtilsOnlineDataFixtures.correct_customized_quantitative_table_data)
      end
    end
  end
end
