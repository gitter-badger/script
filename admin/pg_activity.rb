#!/usr/bin/ruby -w
# pg_activity.rb
# Author: Andy Bettisworth
# Description: Read most recent postgresql server activity

require 'pg'

require_relative 'admin'

module Admin
  # print out postgresql activity
  class PGActivity
    QUERY = 'SELECT * FROM pg_stat_activity'

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

    def report
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

  activity = PGActivity.new
  puts activity.report.class #=> Array
  puts activity.report #=> [{dataid: 16404, dataname: 'raist', ...}]
end
