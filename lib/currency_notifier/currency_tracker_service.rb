# frozen_string_literal: true

require_relative '../../app/models/currency_tracker'

# Service to handle CurrencyTracker part
class CurrencyTrackerService
  def initialize(server_id, user_id, currency_data)
    @server_id = server_id
    @user_id = user_id
    @base_currency = currency_data.fetch(:base)
    @target_currency = currency_data.fetch(:target)
    @lower_threshold = currency_data[:lower_threshold]&.to_f
    @upper_threshold = currency_data[:upper_threshold]&.to_f
  end

  def create_tracker
    retrieved_data = CurrencyTracker.only_deleted.where(**params).first

    if retrieved_data.nil?
      CurrencyTracker.create(**params, lower_threshold: @lower_threshold, upper_threshold: @upper_threshold)
    else
      retrieved_data.update(lower_threshold: @lower_threshold, upper_threshold: @upper_threshold, deleted_at: nil)
    end
  end

  def currency_tracker
    CurrencyTracker.where(**params).first
  end

  def delete_tracker
    tracker = CurrencyTracker.where(**params).first
    tracker&.destroy
  end

  private

  def params
    { discord_server_id: @server_id,
      discord_user_id: @user_id,
      base_currency: @base_currency,
      target_currency: @target_currency }
  end
end
