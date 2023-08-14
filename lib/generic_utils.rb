# frozen_string_literal: true

require_relative 'exceptions'

# Generic Utils Module
module GenericUtils
  include ::CustomExceptions

  def self.prettify_number(number)
    negative_flag = number.negative?
    number_str = number.abs.to_s
    final_number = number_str.reverse.gsub(/...(?=.)/, '\&,').reverse

    final_number.prepend('-') if negative_flag

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
      FileUtils.rm_f(full_path_file)
    end

    true
  end

  def self.file_content(full_path_file)
    file_size = File.size(full_path_file).to_f / (1024**2) # File size in MiB (Mebibyte)
    # formatted_file_size = '%.2f' % file_size

    raise DataIsTooBigToProcess if file_size > 5
    raise DataIsNotOnTheExpectedFormat if File.extname(full_path_file) != '.txt'

    File.read(full_path_file)
  rescue StandardError => e
    puts "ERROR AT #load_file_content //n #{e}"
    raise CouldntRetrieveResource, "I couldn't get file's content"
  end
end
