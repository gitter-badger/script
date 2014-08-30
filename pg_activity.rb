#!/usr/bin/ruby -w
# pg_activity.rb
# Author: Andy Bettisworth
# Description: Read most recent postgresql server activity

# datid | datname | pid  | usesysid | usename | application_name | client_addr
# -------+---------+------+----------+---------+------------------+-------------
#  16505 | raist   | 6839 |    16504 | raist   | psql             |             |

# | client_hostname | client_port |         backend_start         |          xact_start           |
# +-----------------+-------------+-------------------------------+-------------------------------+
#                   |          -1 | 2014-08-24 00:30:51.612085-05 | 2014-08-24 00:30:51.619356-05 |

#           query_start          |         state_change          | waiting | state  |             query
# -------------------------------+-------------------------------+---------+--------+--------------------------------
#  2014-08-24 00:30:51.619356-05 | 2014-08-24 00:30:51.619364-05 | f       | active | SELECT * FROM pg_stat_activity
# (1 row)

require 'pg'

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
      password: 'trichoderma',
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

## USAGE
# activity = PGActivity.new
# puts activity.report.class #=> Array
# puts activity.report #=> [{dataid: 16404, dataname: 'raist', ...}]
