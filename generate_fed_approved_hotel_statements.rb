#!/usr/bin/ruby -w
# generate_fed_approved_hotel_statements.rb
# Author: Andy Bettisworth
# Description: Parse and generate statements for Federally approved motels and hotels (safety)

hotels = File.open('national_list.txt').readlines
hotels.each do |hotel|
  new_hotel = 'FederalApprovedHotel.create('
  hotel_attributes = hotel.split("\t")
  hotel_attributes.each_with_index do |attribute, index|
    unless index == 0
      new_hotel += ", "
    end

    case index
    when 0
      new_hotel += "fema_id: \"#{attribute.strip}\""
    when 1
      new_hotel += "name: \"#{attribute.strip}\""
    when 2
      new_hotel += "po_box: \"#{attribute.strip}\""
    when 3
      new_hotel += "street: \"#{attribute.strip}\""
    when 4
      new_hotel += "city: \"#{attribute.strip}\""
    when 5
      new_hotel += "state: \"#{attribute.strip}\""
    when 6
      new_hotel += "zip_code: \"#{attribute.strip}\""
    when 7
      new_hotel += "stories_count: #{attribute.strip}"
    when 8
      new_hotel += "phone: \"#{attribute.strip}\""
    when 9
      new_hotel += "property_type: \"#{attribute.strip}\""
    when 10
      new_hotel += "has_sprinklers: \"#{attribute.strip}\""
    end

    if index == hotel_attributes.size - 1
      new_hotel += ")"
    end
  end
  puts new_hotel
end
