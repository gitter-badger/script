#!/usr/bin/ruby -w
# add_excel.rb
# Author: Andy Bettisworth
# Description: Adds an excel file using an array for values

require 'spreadsheet'

class SpreadsheetFactory
  def add_workbook(name='workbook', values=[])
    book = Spreadsheet::Workbook.new
    book.write "#{name}.xls"
  end

  def add_worksheets
  end
end

describe SpreadsheetFactory do
  describe "#add_workbook" do
    it "should create an excel workbook named 'coordinates.xls'" do
      excel_factory = SpreadsheetFactory.new
      excel_factory.add_workbook('coordinates')
      expect(File.exist?('coordinates.xls')).to be_true
    end

    it "should create an excel worksheet named 'letters'"
    it "should have a second worksheet with values [[1,1],[1,2],[1,3]]"
  end
end
