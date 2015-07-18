#!/usr/bin/ruby -w
# app_churn.rb
# Author: Andy Bettisworth
# Description: Print the progress of an Application by category

require_relative 'project'

module Project
  def month_before(a_time)
    a_time - 28 * 24 * 60 * 60
  end

  def header(an_svn_date)
    "Changes since #{an_svn_date}:"
  end

  def subsystem_line(subsystem_name, change_count)
    asterisks = asterisks_for(change_count)
    "#{subsystem_name.rjust(14)} #{asterisks} (#{change_count})"
  end

  def asterisks_for(an_integer)
    '*' * (an_integer / 5.0).round
  end

  def change_count_for(name, start_date)
    extract_change_count_from(svn_log(name, start_date))
  end

  def extract_change_count_from(log_text)
    lines = log_text.split("\n")
    dashed_lines = lines.find_all do |line|
      line.include?('-----')
    end
    dashed_lines.length - 1
  end

  def svn_log(subsystem, start_date)
    timespan = "-revision 'HEAD:{#{start_date}}'"
    root = 'svn://rubyforge.org//var/svn/churn-demo'

    'svn log #{timespan} #{root}/#{subsystem}'
  end
end

if __FILE__ == $PROGRAM_NAME
  include Project

  subsystem_names = ['audit', 'fulfillment', 'persistence', 'ui', 'util', 'inventory']
  start_date = month_before(Time.now)

  puts header(start_date)
  subsystem_names.each do |name|
    puts subsystem_line(name, change_count_for(name, start_date))
  end
end
