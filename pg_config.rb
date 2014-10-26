#!/usr/bin/ruby -w
# pg_config.rb
# Author: Andy Bettisworth
# Description: GET configuration file locations

require 'pg'

## > make fault tolerant try/cach
class PGConfig
  QUERY = %q{
    SELECT name, setting
    FROM pg_settings
    WHERE category = 'File Locations'
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

if __FILE__ == $0
  pg_config = PGConfig.new
  puts pg_config.get.class
  puts pg_config.get
end
