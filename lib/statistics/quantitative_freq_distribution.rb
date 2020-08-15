# frozen_string_literal: true

# Quantitative Frequency Distribution Class
class QuantitativeFreqDistribution

  def initialize(data_array:)
    @data_array = data_array.sort
    @max_value = @data_array.max
    @min_value = @data_array.min
  end

  def generate_frequency_table
    k_const = number_of_classes(@data_array.size)
    amplitude_info = @max_value - @min_value
    class_amplitude_info = (class_amplitude amplitude_info, k_const) - 1

    lower_limit = @min_value
    superior_limit = (lower_limit + class_amplitude_info)
    final_table = []

    k_const.times do |index|
      table_line = build_table_line(index, lower_limit, superior_limit)
      lower_limit = superior_limit + 1
      superior_limit = calculate_superior_limit(lower_limit, class_amplitude_info)

      final_table << table_line
    end

    final_table
  end

  def generate_custom_frequency_table(customized_limits:)
    final_table = []

    customized_limits.each_with_index do |values, index|
      lower_limit = values[:lower_limit]
      superior_limit = values[:superior_limit]

      table_line = build_table_line(index, lower_limit, superior_limit)

      table_line[:highlight] = true if values[:highlight]

      final_table << table_line
    end

    final_table
  end

  private

  def number_of_classes(data_array_size)
    # How many classes/bins the the table will have
    Math.sqrt(data_array_size).round
  end

  def class_amplitude(amplitude, k_const)
    # or can be called as bin
    amplitude / (k_const - 1)
  end

  def calculate_superior_limit(lower_limit, class_amplitude_info)
    lower_limit + class_amplitude_info
  end

  def data_counter(lower_limit, superior_limit)
    @data_array.count { |value| value >= lower_limit && value <= superior_limit }
  end

  def build_table_line(index, lower_limit, superior_limit)
    {
      class_position: index,
      class_text: generate_table_text(lower_limit, superior_limit),
      class_count: data_counter(lower_limit, superior_limit)
    }
  end

  def generate_table_text(lower_limit, superior_limit)
    max_length = @max_value.digits.size
    "#{lower_limit.to_s.ljust(max_length)} |---- #{superior_limit.to_s.ljust(max_length)}"
  end
end
