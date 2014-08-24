#!/usr/bin/ruby -w
# pg_settings.rb
# Author: Andy Bettisworth
# Description: READ current postgresql.conf settings

require 'pg'

# > TODO (optional) pass settings dynamically to class

class PGSettings
  QUERY = %q{
    SELECT name, context, unit, setting, boot_val, reset_val
    FROM pg_settings
    WHERE name
    in('listen_addresses', 'max_connections', 'shared_buffers',
      'effective_cache_size', 'work_mem', 'maintenance_work_mem')
      ORDER BY context, name;
  }

  attr_accessor :conn

  def initialize
    connection
  end

  def connection
    @conn = PG.connect(
      dbname: 'raist',
      user: 'raist',
      password: 'trichoderma',
    )
  end

  def get
    config = []
    response = conn.exec QUERY
    response.each do |row|
      config << row
    end
    config
  end
end

pg_settings = PGSettings.new
puts pg_settings.get.class
puts pg_settings.get
