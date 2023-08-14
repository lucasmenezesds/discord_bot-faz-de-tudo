# frozen_string_literal: true

require 'fileutils'
require 'rspec'
require_relative '../../lib/generic_utils'

describe GenericUtils do
  let(:working_directory) { "#{Dir.pwd}/spec/fixtures/discord_attachment/" }

  context 'Successful Cases' do
    describe '#prettify_number' do
      it 'should return the number with a comma in the thousands' do
        result = described_class.prettify_number(510_250)

        expect(result).to eq('510,250')
      end
    end

    describe '#list_files' do
      it 'should return a list of files from the specified directory' do
        file_path = "#{working_directory}/file.txt"
        FileUtils.touch(file_path) unless File.exist?(file_path)

        result = described_class.list_files(working_directory)

        expect(result).to match_array(%w[file.txt .gitkeep . ..])
      end
    end

    describe '#delete_all_files' do
      it 'should remove all the files from the specified directory except from .gitkeep' do
        file_path = "#{working_directory}/file.txt"
        FileUtils.touch(file_path) unless File.exist?(file_path)

        result = described_class.delete_all_files(working_directory)
        files_list = described_class.list_files(working_directory)

        expect(result).to be_truthy
        expect(files_list).to match_array(%w[.gitkeep . ..])
      end
    end
  end
end
