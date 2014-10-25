#/usr/bin/ruby -w
# extract_excel.rb
# Author: Andy Bettisworth
# Description: Read excel spreadsheet values as an Array

require 'spreadsheet'

class SpreadsheetArray
  def extract(name)
    name = default_extension(name)
    raise "ExcelFileNotFoundError! No file named #{name}" unless File.exist?(name)
    raise 'ExcelFileRequiredError!' unless File.extname(name) == '.xls'

    all_values = []
    book = Spreadsheet.open name
    book.worksheets.each do |sheet|
      sheet.each do |row|
        row_array = []
        row.each do |col|
          row_array << col
        end
        all_values << row_array
      end
    end

    puts all_values.inspect
    all_values
  end

  def default_extension(excel)
    if File.extname(excel) == ''
      excel += '.xls'
    end
    excel
  end
end

if __FILE__ == $0
  excel_array = SpreadsheetArray.new
  if ARGV[0]
    excel_array.extract(ARGV[0])
  else
    puts "USAGE: extract_excel NAME"
  end
end
