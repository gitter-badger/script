#!/usr/bin/ruby -w
# pg_explain.rb
# Author: Andy Bettisworth
# Description: Explain query performance

require 'pg'

class PGExplain
  conn = PG.connect(
    dbname: 'raist',
    user: 'raist',
    password: 'trichoderma',
  )

  attr_accessor :conn
  attr_accessor :query

  def exec_query
    # > handle connection
    if @query
      response = @conn.exec "EXPLAIN ANALYZE #{@query}"
    else
      raise 'No @query set'
    end
  end

  def parse_response
    response.each_with_index do |row, index|
      plan_match = /(?<plan>.*?)\(/.match(row['QUERY PLAN']) if index == 0
      filter_match = /Filter: \((?<filters>\w.*?)\)/.match(row['QUERY PLAN'])
      filtered_rows_match = /Rows Removed by Filter: (?<filtered_rows>\d*)/.match(row['QUERY PLAN'])
      runtime_match = /Total runtime: (?<runtime>\d*?\.\d*?)\s/.match(row['QUERY PLAN'])

      @plan = plan_match['plan'] if plan_match
      @filters = filter_match['filters'] if filter_match
      @filtered_row_count = filtered_rows_match['filtered_rows'] if filtered_rows_match
      @runtime = runtime_match['runtime'] if runtime_match
    end
  end

  def report
    puts "plan:     #{@plan}"
    puts "filters:  #{@filters}"
    puts "filtered: #{@filtered_row_count} rows"
    puts "runtime:  #{@runtime} ms"
  end
end

analyze = PGExplain.new
analyze.query = %q{
  SELECT name, setting
  FROM pg_settings
  WHERE category = 'File Locations'
}
analyze.report
