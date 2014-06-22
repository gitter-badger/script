#!/usr/bin/ruby -w
# create_excel.rb
# Author: Andy Bettisworth
# Description: Create an excel file using an array for values

require 'spreadsheet'
require 'yaml'

class SpreadsheetFactory
  def add_workbook(name, *args)
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet

    if args
      args.each do |arg|
        arg.each_with_index do |row, arg_index|
          next if arg_index == 0
          col = row.split(',')
          col.each_with_index do |value, col_index|
            sheet[arg_index - 1, col_index] = value
          end
        end
      end
    end

    book.write "#{name}.xls"
  end
end

excel_factory = SpreadsheetFactory.new
if ARGV[0] && ARGV[1]
  excel_factory.add_workbook(ARGV[0], ARGV)
elsif ARGV[0]
  excel_factory.add_workbook(ARGV[0])
else
  puts "USAGE: create_excel 'NAME' [VALUES]"
end

# describe SpreadsheetFactory do
#   describe "#add_workbook" do
#     it "should create an excel workbook named 'coordinates.xls'" do
#       excel_factory = SpreadsheetFactory.new
#       excel_factory.add_workbook('coordinates')
#       expect(File.exist?('coordinates.xls')).to be_true
#     end

#     it "should create an excel worksheet named 'letters'"
#     it "should have a second worksheet with values [[1,1],[1,2],[1,3]]"
#   end
# end
