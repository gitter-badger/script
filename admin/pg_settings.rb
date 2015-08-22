#!/usr/bin/ruby -w
# pg_settings.rb
# Author: Andy Bettisworth
# Description: Read current postgresql.conf settings

require 'pg'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # Read postgresql settings from configuration
  class PGSettings
    QUERY = %q(
      SELECT name, context, unit, setting, boot_val, reset_val
      FROM pg_settings
      WHERE name
      in('listen_addresses', 'max_connections', 'shared_buffers',
        'effective_cache_size', 'work_mem', 'maintenance_work_mem')
        ORDER BY context, name;
    )

    attr_accessor :conn

    def initialize
      connection
    end

    def connection
      @conn = PG.connect(
        dbname: 'raist',
        user: 'raist',
        password: 'trichoderma'
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
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  pg_settings = PGSettings.new
  puts pg_settings.get.class
  puts pg_settings.get
end
