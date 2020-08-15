# frozen_string_literal: true

# Class for Custom Settings
module CustomizedSettings
  def self.tibia_level_frequency
    [
      {
        lower_limit: 1,
        superior_limit: 149
      },
      {
        lower_limit: 150,
        superior_limit: 250,
        highlight: true
      },
      {
        lower_limit: 251,
        superior_limit: 400
      },
      {
        lower_limit: 401,
        superior_limit: 700
      },
      {
        lower_limit: 701,
        superior_limit: 1500
      }
    ]
  end
end
