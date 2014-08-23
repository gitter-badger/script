#!/usr/bin/ruby -w
# pg_settings.rb
# Author: Andy Bettisworth
# Description: READ current postgresql.conf settings


class PGSettings
  QUERY = %q{
    SELECT name, context, unit, setting, boot_val, reset_val
    FROM pg_settings
    WHERE name
    in('listen_addresses', 'max_connections', 'shared_buffers',
      'effective_cache_size', 'work_mem', 'maintenance_work_mem'
      ORDER BY context, name;
  }

  def initialize
  end
end

pg_settings = PGSettings.new
puts pg_settings.get.class
puts pg_settings.get
