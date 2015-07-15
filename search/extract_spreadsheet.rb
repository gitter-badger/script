#!/usr/bin/ruby -w
# extract_spreadsheet.rb
# Author: Andy Bettisworth
# Description: Use spreadsheet gem to extract contact information

require 'spreadsheet'

book   = Spreadsheet.open 'customer_contacts.xls'
sheet1 = book.worksheet 0

model_name = 'accounts.Person'

columns = sheet1.row(0).to_a
columns.select! do |col|
  col.downcase!
  col.gsub!(/\s/, '_')
end
puts columns.inspect

sheet1.rows.each_with_index do |contact, contact_index|
  contact_yml = <<-STR
 - model: #{model_name}
   pk: #{contact_index + 9}
  STR

  contact.to_a.each_with_index do |value, value_index|
    if columns[value_index] and value
      contact_yml += <<-STR
      #{columns[value_index]}: "#{value}"
      STR
    end
  end

  puts contact_yml
end
