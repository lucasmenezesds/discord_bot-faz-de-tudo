# frozen_string_literal: true

# Generic Utils Module
module GenericUtils
  def self.prettify_number(number)
    negative_flag = number.negative?
    number_str = number.abs.to_s
    final_number = number_str.reverse.gsub(/...(?=.)/, '\&,').reverse

    final_number = final_number.prepend('-') if negative_flag

    final_number
  end
end
