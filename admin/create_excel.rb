#!/usr/bin/ruby -w
# create_excel.rb
# Author: Andy Bettisworth
# Description: Create an excel file using an array for values

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

require 'spreadsheet'
require 'yaml'

module Admin
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
              sheet[arg_index - 1, col_index] = value.strip
            end
          end
        end
      end

      book.write "#{name}.xls"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  excel_factory = SpreadsheetFactory.new
  if ARGV[0] && ARGV[1]
    excel_factory.add_workbook(ARGV[0], ARGV)
  elsif ARGV[0]
    excel_factory.add_workbook(ARGV[0])
  else
    puts "USAGE: create_excel 'NAME' [VALUES]"
  end
end
