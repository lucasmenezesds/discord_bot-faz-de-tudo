Sequel.migration do
  change do
    create_table(:currency_trackers) do
      primary_key :id
      Bignum :discord_server_id, null: false
      Bignum :discord_user_id, null: false
      String :base_currency, null: false
      String :target_currency, null: false
      Float :upper_threshold
      Float :lower_threshold
      DateTime :deleted_at, default: nil

      sleep 1
      index [:discord_user_id, :discord_server_id], unique: true
      index :base_currency
      index :target_currency
      index [:discord_user_id, :discord_server_id, :base_currency, :target_currency], unique: true
      index :deleted_at
    end
  end
end
