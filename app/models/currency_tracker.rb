# frozen_string_literal: true

require_relative '../../config/database'

# Currency Tracker Model
class CurrencyTracker < Sequel::Model
  dataset_module do
    def active
      where(deleted_at: nil)
    end

    def only_deleted
      unfiltered.exclude(deleted_at: nil)
    end
  end

  def self.dataset
    super.active
  end

  def destroy
    update(deleted_at: Time.now.utc)
  end

  def really_destroy
    delete
  end

  def restore
    update(deleted_at: nil)
  end
end
