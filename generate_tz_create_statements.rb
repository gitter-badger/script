#!/usr/bin/ruby -w
# generate_tz_create_statements.rb
# Author: Andy Bettisworth
# Description: Parse a TZ tabbed file to gen ActiveRecord.create seed statements

zones = File.open('zone.tab').readlines
zones.each do |zone|
  new_zone = 'Timezone.create('
  zone.split("\t").each_with_index do |zone_value, index|
    case index
    when 0
      new_zone += "country_code: \'#{zone_value.strip}\', "
    when 1
      new_zone += "coordinates: \'#{zone_value.strip}\', "
    when 2
      new_zone += "zone: \'#{zone_value.strip}\')"
    end
  end
  puts new_zone
end
