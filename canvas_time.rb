#!/usr/bin/ruby -w
# canvas_time.rb
# Description: Canvas Time class

## READ current time
# puts Time.now
#=> 2014-02-06 19:43:51 -0600

## READ formatted time
# puts Time.now.strftime('%Y%m%d%H%M')
#=> 201402062340

## Add 5 ... adds 5 seconds
# puts Time.now
#=> 2014-02-06 23:43:06 -0600
# puts Time.now + 5
#=> 2014-02-06 23:43:11 -0600

## Add 5 minutes
# puts Time.now
#=> 2014-02-06 23:44:32 -0600
# puts Time.now + 60*5
#=> 2014-02-06 23:49:32 -0600

## READ Hours and Minutes
# puts Time.now.strftime('%H%M')
#=> 2347
# puts Time.now.strftime('%T')
#=> 23:47:20

## ri Documentation
## Time < Object

# ------------------------------------------------------------------------------
# = IInncclluuddeess::
# Comparable (from ruby core)

# DateAndTime::Calculations (from gem activesupport-4.0.2)

# Mocha::TimeMethods (from gem mocha-1.0.0)

# TimeDummy (from gem tins-0.13.1)

# (from ruby core)
# ------------------------------------------------------------------------------
# Time serialization/deserialization

## time.rb

# When 'time' is required, Time is extended with additional methods for parsing
# and converting Times.

## Features

# This library extends the Time class with the following conversions between
# date strings and Time objects:

# * date-time defined by {RFC 2822}[http://www.ietf.org/rfc/rfc2822.txt]
# * HTTP-date defined by {RFC 2616}[http://www.ietf.org/rfc/rfc2616.txt]
# * dateTime defined by XML Schema Part 2: Datatypes ({ISO
#   8601}[http://www.iso.org/iso/date_and_time_format])
# * various formats handled by Date._parse
# * custom formats handled by Date._strptime

## Examples

# All examples assume you have loaded Time with:
#   require 'time'

# All of these examples were done using the EST timezone which is GMT-5.

# === CCoonnvveerrttiinngg  ttoo  aa  SSttrriinngg

#   t = Time.now
#   t.iso8601  # => "2011-10-05T22:26:12-04:00"
#   t.rfc2822  # => "Wed, 05 Oct 2011 22:26:12 -0400"
#   t.httpdate # => "Thu, 06 Oct 2011 02:26:12 GMT"

# === TTiimmee..ppaarrssee

# #parse takes a string representation of a Time and attempts to parse it using
# a heuristic.

#   Date.parse("2010-10-31") #=> 2010-10-31 00:00:00 -0500

# Any missing pieces of the date are inferred based on the current date.

#   # assuming the current date is "2011-10-31"
#   Time.parse("12:00") #=> 2011-10-31 12:00:00 -0500

# We can change the date used to infer our missing elements by passing a second
# object that responds to #mon, #day and #year, such as Date, Time or DateTime.
# We can also use our own object.

#   class MyDate
#     attr_reader :mon, :day, :year

#     def initialize(mon, day, year)
#       @mon, @day, @year = mon, day, year
#     end
#   end

#   d  = Date.parse("2010-10-28")
#   t  = Time.parse("2010-10-29")
#   dt = DateTime.parse("2010-10-30")
#   md = MyDate.new(10,31,2010)

#   Time.parse("12:00", d)  #=> 2010-10-28 12:00:00 -0500
#   Time.parse("12:00", t)  #=> 2010-10-29 12:00:00 -0500
#   Time.parse("12:00", dt) #=> 2010-10-30 12:00:00 -0500
#   Time.parse("12:00", md) #=> 2010-10-31 12:00:00 -0500

# #parse also accepts an optional block. You can use this block to specify how
# to handle the year component of the date. This is specifically designed for
# handling two digit years. For example, if you wanted to treat all two digit
# years prior to 70 as the year 2000+ you could write this:

#   Time.parse("01-10-31") {|year| year + (year < 70 ? 2000 : 1900)}
#   #=> 2001-10-31 00:00:00 -0500
#   Time.parse("70-10-31") {|year| year + (year < 70 ? 2000 : 1900)}
#   #=> 1970-10-31 00:00:00 -0500

# === TTiimmee..ssttrrppttiimmee

# #strptime works similar to parse except that instead of using a heuristic to
# detect the format of the input string, you provide a second argument that
# describes the format of the string. For example:

#   Time.strptime("2000-10-31", "%Y-%m-%d") #=> 2000-10-31 00:00:00 -0500

# Time is an abstraction of dates and times. Time is stored internally as the
# number of seconds with fraction since the _E_p_o_c_h, January 1, 1970
# 00:00 UTC. Also see the library module Date. The Time class treats GMT
# (Greenwich Mean Time) and UTC (Coordinated Universal Time) as equivalent. GMT
# is the older way of referring to these baseline times but persists in the
# names of calls on POSIX systems.

# All times may have fraction. Be aware of this fact when comparing times with
# each other -- times that are apparently equal when displayed may be different
# when compared.

# Since Ruby 1.9.2, Time implementation uses a signed 63 bit integer, Bignum or
# Rational. The integer is a number of nanoseconds since the _E_p_o_c_h
# which can represent 1823-11-12 to 2116-02-20. When Bignum or Rational is used
# (before 1823, after 2116, under nanosecond), Time works slower as when integer
# is used.

# = EExxaammpplleess

# All of these examples were done using the EST timezone which is GMT-5.

# == CCrreeaattiinngg  aa  nneeww  TTiimmee  iinnssttaannccee

# You can create a new instance of Time with Time::new. This will use the
# current system time. Time::now is an alias for this. You can also pass parts
# of the time to Time::new such as year, month, minute, etc. When you want to
# construct a time this way you must pass at least a year. If you pass the year
# with nothing else time will default to January 1 of that year at 00:00:00 with
# the current system timezone. Here are some examples:

#   Time.new(2002)         #=> 2002-01-01 00:00:00 -0500
#   Time.new(2002, 10)     #=> 2002-10-01 00:00:00 -0500
#   Time.new(2002, 10, 31) #=> 2002-10-31 00:00:00 -0500
#   Time.new(2002, 10, 31, 2, 2, 2, "+02:00") #=> 2002-10-31 02:02:02 +0200

# You can also use #gm, #local and #utc to infer GMT, local and UTC timezones
# instead of using the current system setting.

# You can also create a new time using Time::at which takes the number of
# seconds (or fraction of seconds) since the {Unix
# Epoch}[http://en.wikipedia.org/wiki/Unix_time].

#   Time.at(628232400) #=> 1989-11-28 00:00:00 -0500

# == WWoorrkkiinngg  wwiitthh  aann  iinnssttaannccee  ooff  TTiimmee

# Once you have an instance of Time there is a multitude of things you can do
# with it. Below are some examples. For all of the following examples, we will
# work on the assumption that you have done the following:

#   t = Time.new(1993, 02, 24, 12, 0, 0, "+09:00")

# Was that a monday?

#   t.monday? #=> false

# What year was that again?

#   t.year #=> 1993

# Was is daylight savings at the time?

#   t.dst? #=> false

# What's the day a year later?

#   t + (60*60*24*365) #=> 1994-02-24 12:00:00 +0900

# How many seconds was that since the Unix Epoch?

#   t.to_i #=> 730522800

# You can also do standard functions like compare two times.

#   t1 = Time.new(2010)
#   t2 = Time.new(2011)

#   t1 == t2 #=> false
#   t1 == t1 #=> true
#   t1 <  t2 #=> true
#   t1 >  t2 #=> false

#   Time.new(2010,10,31).between?(t1, t2) #=> true
# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::

#   at
#   gm
#   json_create
#   local
#   mktime
#   new
#   now
#   utc

## Instance methods

#   +
#   -
#   <=>
#   apply_offset
#   as_json
#   asctime
#   ctime
#   day
#   dst?
#   eql?
#   friday?
#   getgm
#   getlocal
#   getutc
#   gmt?
#   gmt_offset
#   gmtime
#   gmtoff
#   hash
#   hour
#   httpdate
#   inspect
#   isdst
#   iso8601
#   localtime
#   make_time
#   mday
#   min
#   mon
#   monday?
#   month
#   month_days
#   nsec
#   parse
#   rake_original_time_compare
#   rfc2822
#   rfc822
#   round
#   saturday?
#   sec
#   strftime
#   strptime
#   subsec
#   succ
#   sunday?
#   thursday?
#   to_a
#   to_date
#   to_datetime
#   to_f
#   to_i
#   to_json
#   to_r
#   to_s
#   to_time
#   tuesday?
#   tv_nsec
#   tv_sec
#   tv_usec
#   usec
#   utc
#   utc?
#   utc_offset
#   w3cdtf
#   wday
#   wednesday?
#   xmlschema
#   yday
#   year
#   zone
#   zone_offset
#   zone_utc?

# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------




# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::

# COMMON_YEAR_DAYS_IN_MONTH:
#   [not documented]

# DATE_FORMATS:
#   [not documented]


# = CCllaassss  mmeetthhooddss::

#   zone_default

## Instance methods

#   -
#   <=>
#   ===
#   _dump
#   _dump_without_zone
#   _load
#   acts_like_time?
#   advance
#   ago
#   all_day
#   all_month
#   all_quarter
#   all_week
#   all_year
#   at_beginning_of_day
#   at_beginning_of_hour
#   at_beginning_of_minute
#   at_end_of_day
#   at_end_of_hour
#   at_end_of_minute
#   at_midnight
#   at_with_coercion
#   beginning_of_day
#   beginning_of_hour
#   beginning_of_minute
#   change
#   compare_with_coercion
#   compare_without_coercion
#   current
#   days_in_month
#   end_of_day
#   end_of_hour
#   end_of_minute
#   eql?
#   eql_with_coercion
#   eql_without_coercion
#   find_zone
#   find_zone!
#   formatted_offset
#   in
#   in_time_zone
#   local_time
#   midnight
#   minus_with_coercion
#   minus_without_coercion
#   minus_without_duration
#   seconds_since_midnight
#   seconds_until_end_of_day
#   since
#   time_with_datetime_fallback
#   to_default_s
#   to_formatted_s
#   to_s
#   use_zone
#   utc_time
#   zone
#   zone=

# = AAttttrriibbuutteess::

#   attr_accessor zone_default

# (from gem json-1.8.1)
# ------------------------------------------------------------------------------
# Time serialization/deserialization
# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::

#   json_create

# = IInnssttaannccee  mmeetthhooddss::

#   as_json
#   to_json

# (from gem rake-10.1.1)
# ------------------------------------------------------------------------------
# = IInnssttaannccee  mmeetthhooddss::

#   <=>
#   rake_original_time_compare

# ------------------------------------------------------------------------------
# Also found in:
#   gem mocha-1.0.0
#   gem tins-0.13.1

# = TTiimmee..ssttrrffttiimmee

# (from ruby core)
# ------------------------------------------------------------------------------
#   time.strftime( string ) -> string

# ------------------------------------------------------------------------------

# Formats _t_i_m_e according to the directives in the given format string.

# The directives begin with a percent (%) character. Any text not listed as a
# directive will be passed through to the output string.

# The directive consists of a percent (%) character, zero or more flags,
# optional minimum field width, optional modifier and a conversion specifier as
# follows:

#   %<flags><width><modifier><conversion>

# Flags:
#   -  don't pad a numerical output
#   _  use spaces for padding
#   0  use zeros for padding
#   ^  upcase the result string
#   #  change case
#   :  use colons for %z

# The minimum field width specifies the minimum width.

# The modifiers are "E" and "O". They are ignored.

## Format directives
#   Date (Year, Month, Day):
#     %Y - Year with century (can be negative, 4 digits at least)
#             -0001, 0000, 1995, 2009, 14292, etc.
#     %C - year / 100 (rounded down such as 20 in 2009)
#     %y - year % 100 (00..99)
#     %m - Month of the year, zero-padded (01..12)
#             %_m  blank-padded ( 1..12)
#             %-m  no-padded (1..12)
#     %B - The full month name (``January'')
#             %^B  uppercased (``JANUARY'')
#     %b - The abbreviated month name (``Jan'')
#             %^b  uppercased (``JAN'')
#     %h - Equivalent to %b
#     %d - Day of the month, zero-padded (01..31)
#             %-d  no-padded (1..31)
#     %e - Day of the month, blank-padded ( 1..31)
#     %j - Day of the year (001..366)

#   Time (Hour, Minute, Second, Subsecond):
#     %H - Hour of the day, 24-hour clock, zero-padded (00..23)
#     %k - Hour of the day, 24-hour clock, blank-padded ( 0..23)
#     %I - Hour of the day, 12-hour clock, zero-padded (01..12)
#     %l - Hour of the day, 12-hour clock, blank-padded ( 1..12)
#     %P - Meridian indicator, lowercase (``am'' or ``pm'')
#     %p - Meridian indicator, uppercase (``AM'' or ``PM'')
#     %M - Minute of the hour (00..59)
#     %S - Second of the minute (00..60)
#     %L - Millisecond of the second (000..999)
#          The digits under millisecond are truncated to not produce 1000.
#     %N - Fractional seconds digits, default is 9 digits (nanosecond)
#             %3N  millisecond (3 digits)
#             %6N  microsecond (6 digits)
#             %9N  nanosecond (9 digits)
#             %12N picosecond (12 digits)
#             %15N femtosecond (15 digits)
#             %18N attosecond (18 digits)
#             %21N zeptosecond (21 digits)
#             %24N yoctosecond (24 digits)
#          The digits under the specified length are truncated to avoid
#          carry up.

#   Time zone:
#     %z - Time zone as hour and minute offset from UTC (e.g. +0900)
#             %:z - hour and minute offset from UTC with a colon (e.g. +09:00)
#             %::z - hour, minute and second offset from UTC (e.g. +09:00:00)
#     %Z - Abbreviated time zone name or similar information.

#   Weekday:
#     %A - The full weekday name (``Sunday'')
#             %^A  uppercased (``SUNDAY'')
#     %a - The abbreviated name (``Sun'')
#             %^a  uppercased (``SUN'')
#     %u - Day of the week (Monday is 1, 1..7)
#     %w - Day of the week (Sunday is 0, 0..6)

#   ISO 8601 week-based year and week number:
#   The first week of YYYY starts with a Monday and includes YYYY-01-04.
#   The days in the year before the first week are in the last week of
#   the previous year.
#     %G - The week-based year
#     %g - The last 2 digits of the week-based year (00..99)
#     %V - Week number of the week-based year (01..53)

#   Week number:
#   The first week of YYYY that starts with a Sunday or Monday (according to %U
#   or %W). The days in the year before the first week are in week 0.
#     %U - Week number of the year. The week starts with Sunday. (00..53)
#     %W - Week number of the year. The week starts with Monday. (00..53)

#   Seconds since the Epoch:
#     %s - Number of seconds since 1970-01-01 00:00:00 UTC.

#   Literal string:
#     %n - Newline character (\n)
#     %t - Tab character (\t)
#     %% - Literal ``%'' character

#   Combination:
#     %c - date and time (%a %b %e %T %Y)
#     %D - Date (%m/%d/%y)
#     %F - The ISO 8601 date format (%Y-%m-%d)
#     %v - VMS date (%e-%^b-%4Y)
#     %x - Same as %D
#     %X - Same as %T
#     %r - 12-hour time (%I:%M:%S %p)
#     %R - 24-hour time (%H:%M)
#     %T - 24-hour time (%H:%M:%S)

# This method is similar to strftime() function defined in ISO C and POSIX.

# While all directives are locale independent since Ruby 1.9, %Z is platform
# dependent. So, the result may differ even if the same format string is used in
# other systems such as C.

# %z is recommended over %Z. %Z doesn't identify the timezone. For example,
# "CST" is used at America/Chicago (-06:00), America/Havana (-05:00),
# Asia/Harbin (+08:00), Australia/Darwin (+09:30) and Australia/Adelaide
# (+10:30). Also, %Z is highly dependent on the operating system. For example,
# it may generate a non ASCII string on Japanese Windows. i.e. the result can be
# different to "JST". So the numeric time zone offset, %z, is recommended.

# Examples:

#   t = Time.new(2007,11,19,8,37,48,"-06:00") #=> 2007-11-19 08:37:48 -0600
#   t.strftime("Printed on %m/%d/%Y")   #=> "Printed on 11/19/2007"
#   t.strftime("at %I:%M%p")            #=> "at 08:37AM"

# Various ISO 8601 formats:
#   %Y%m%d           => 20071119                  Calendar date (basic)
#   %F               => 2007-11-19                Calendar date (extended)
#   %Y-%m            => 2007-11                   Calendar date, reduced accuracy, specific month
#   %Y               => 2007                      Calendar date, reduced accuracy, specific year
#   %C               => 20                        Calendar date, reduced accuracy, specific century
#   %Y%j             => 2007323                   Ordinal date (basic)
#   %Y-%j            => 2007-323                  Ordinal date (extended)
#   %GW%V%u          => 2007W471                  Week date (basic)
#   %G-W%V-%u        => 2007-W47-1                Week date (extended)
#   %GW%V            => 2007W47                   Week date, reduced accuracy, specific week (basic)
#   %G-W%V           => 2007-W47                  Week date, reduced accuracy, specific week (extended)
#   %H%M%S           => 083748                    Local time (basic)
#   %T               => 08:37:48                  Local time (extended)
#   %H%M             => 0837                      Local time, reduced accuracy, specific minute (basic)
#   %H:%M            => 08:37                     Local time, reduced accuracy, specific minute (extended)
#   %H               => 08                        Local time, reduced accuracy, specific hour
#   %H%M%S,%L        => 083748,000                Local time with decimal fraction, comma as decimal sign (basic)
#   %T,%L            => 08:37:48,000              Local time with decimal fraction, comma as decimal sign (extended)
#   %H%M%S.%L        => 083748.000                Local time with decimal fraction, full stop as decimal sign (basic)
#   %T.%L            => 08:37:48.000              Local time with decimal fraction, full stop as decimal sign (extended)
#   %H%M%S%z         => 083748-0600               Local time and the difference from UTC (basic)
#   %T%:z            => 08:37:48-06:00            Local time and the difference from UTC (extended)
#   %Y%m%dT%H%M%S%z  => 20071119T083748-0600      Date and time of day for calendar date (basic)
#   %FT%T%:z         => 2007-11-19T08:37:48-06:00 Date and time of day for calendar date (extended)
#   %Y%jT%H%M%S%z    => 2007323T083748-0600       Date and time of day for ordinal date (basic)
#   %Y-%jT%T%:z      => 2007-323T08:37:48-06:00   Date and time of day for ordinal date (extended)
#   %GW%V%uT%H%M%S%z => 2007W471T083748-0600      Date and time of day for week date (basic)
#   %G-W%V-%uT%T%:z  => 2007-W47-1T08:37:48-06:00 Date and time of day for week date (extended)
#   %Y%m%dT%H%M      => 20071119T0837             Calendar date and local time (basic)
#   %FT%R            => 2007-11-19T08:37          Calendar date and local time (extended)
#   %Y%jT%H%MZ       => 2007323T0837Z             Ordinal date and UTC of day (basic)
#   %Y-%jT%RZ        => 2007-323T08:37Z           Ordinal date and UTC of day (extended)
#   %GW%V%uT%H%M%z   => 2007W471T0837-0600        Week date and local time and difference from UTC (basic)
#   %G-W%V-%uT%R%:z  => 2007-W47-1T08:37-06:00    Week date and local time and difference from UTC (extended)
