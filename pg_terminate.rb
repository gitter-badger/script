#!/usr/bin/ruby -w
# pg_terminate.rb
# Author: Andy Bettisworth
# Description: Delete all/specific connections to a postgresql server

require 'pg'
require_relative 'pg_activity'

class PGTerminate
  def close_all
    activity = PGActivity.new
    active_queries = activity.report
    active_queries.each do |query|
      pid = query['pid'].to_i
      `kill -9 #{pid}`
    end
  end
end

## USAGE
# terminator = PGTerminate.new
# terminator.close_all
