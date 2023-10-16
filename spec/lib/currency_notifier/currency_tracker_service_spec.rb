# frozen_string_literal: true

require 'rspec'

require_relative '../../../lib/currency_notifier/currency_tracker_service'

describe CurrencyTrackerService, integrated: true do
  let!(:currency_data) { { base: 'USD', target: 'JPY', upper_threshold: 150.0, lower_threshold: 130.0 } }

  before do
    DB[:currency_trackers].delete
  end

  context 'when the currency_tracker doesnt exist' do
    describe '#create_tracker' do
      it 'creates a new tracker for the currencies for the user and that specific server' do
        expect do
          cts = CurrencyTrackerService.new(123, 123, currency_data)
          cts.create_tracker
        end.to change(CurrencyTracker, :count).by(1)
      end
    end
  end

  context 'when the currency_tracker exists' do
    before do
      params = { discord_server_id: 4321,
                 discord_user_id: 4321,
                 base_currency: 'USD',
                 target_currency: 'JPY' }

      CurrencyTracker.create(**params, lower_threshold: 150, upper_threshold: 145)
    end

    describe '#currency_tracker' do
      it 'returns the expected tracker' do
        cts = CurrencyTrackerService.new(4321, 4321, { base: 'USD', target: 'JPY' })
        tracker = cts.currency_tracker

        expect(tracker.class.to_s).to eq('CurrencyTracker')
      end
    end

    describe '#delete_tracker' do
      it 'soft deletes the tracker' do
        expect do
          cts = CurrencyTrackerService.new(4321, 4321, currency_data)
          cts.delete_tracker
        end.to change { CurrencyTracker.unfiltered.count }.by(0).and(
          change(CurrencyTracker, :count).by(-1)
        )
      end
    end
  end

  context 'when the currency_tracker is soft deleted' do
    before do
      params = { discord_server_id: 321,
                 discord_user_id: 321,
                 base_currency: 'USD',
                 target_currency: 'JPY' }

      CurrencyTracker.create(**params, lower_threshold: 150, upper_threshold: 130, deleted_at: Time.now.utc)
    end

    describe '#create_tracker' do
      it 'updates the soft deleted tracker for the currencies for the user and that specific server' do
        expect do
          cts = CurrencyTrackerService.new(321, 321, currency_data)
          cts.create_tracker
        end.to change { CurrencyTracker.unfiltered.count }.by(0).and(
          change(CurrencyTracker, :count).by(1)
        )
      end
    end

    describe '#currency_tracker' do
      it 'returns nil when the tracker is searched' do
        cts = CurrencyTrackerService.new(321, 321, currency_data)
        tracker = cts.currency_tracker

        expect(tracker).to be_nil
      end
    end
  end
end
