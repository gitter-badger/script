#!/usir/bin/ruby -w
# list_files.rb
# Author: Andy Bettisworth
# Description: To sort and filter files

require 'optparse'

class FileList
  def sort
    Dir['**']
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: list_files [options]'

  opts.on('')
end
option_parser.parse!

describe FileList do
  before(:each) do
    File.new('test1.rb', 'w')
    File.new('test2.rb', 'w')
    File.new('test3.rb', 'w')
  end

  after(:each) do
    File.delete('test1.rb')
    File.delete('test2.rb')
    File.delete('test3.rb')
  end

  describe "#sort" do
    it "should list the names of all files within current directory" do
      lister = FileList.new
      list = lister.sort
      expect(list).to include "test1.rb", "test2.rb", "test3.rb"
    end

    it "should list the names of all files within target directory" do
      lister = FileList.new
      options[:target_dir] = "test_directory"
      list = lister.sort()
    end

    it "should sort list by datetime created"
    it "should sort list by datetime modified"
    it "should sort list by permission levels"
  end
end
