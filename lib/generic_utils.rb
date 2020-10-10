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

  def self.list_files(directory)
    return Dir.entries(directory) if directory

    []
  end

  def self.delete_all_files(full_path_directory)
    return false unless full_path_directory

    list_files(full_path_directory).each do |file_name|
      next if %w[. .. .gitkeep].include?(file_name)

      full_path_file = "#{full_path_directory}#{file_name}"
      File.delete(full_path_file) if File.exist?(full_path_file)
    end

    true
  end
end
