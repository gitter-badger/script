#!/usr/bin/ruby -w
# canvas_timers.rb
# Author: Andy Bettisworth
# Description: Canvas Timers gem

require 'timers'

## SUCCESSFUL: stupid iterator... just use 6.times{}
# timer1 = Timers.new
# three_second_timer = timer1.every(3) { puts "Take 3" }
# token = 0
# while token < 6 do
#   if token % 2 == 1
#     puts 'Let the odds be ever in your favor.'
#   end
#   timer1.wait
#   token += 1
# end

## SUCCESSFUL: repeat timer proc
timer1 = Timers.new
three_second_timer = timer1.every(3) { puts "Take 3" }
4.times { timer1.wait }

## TEST failed: repeat timer proc
## NOTE failed because we used after() and not every()
# timer1 = Timers.new
# three_second_timer = timer1.after(3) { puts "Take 3" }
# 3.times { timer1.wait }

## TEST failed: Cancel schedule proc
## NOTE the reason is the order in which we call wait() and cancel()
# timer1 = Timers.new
# five_second_timer = timer1.after(5) { puts "Take 5" }
# timer1.wait
# five_second_timer.cancel

## SUCCESSFUL: Cancel scheduled proc
# timer1 = Timers.new
# five_second_timer = timer1.after(5) { puts "Take 5" }
# five_second_timer.cancel
# timer1.wait

## SUCCESSFUL: Executes wait() sequentially; wait 3, wait 10
# timer1 = Timers.new
# timer2 = Timers.new
# five_second_timer = timer1.after(3) { puts "Take 3" }
# three_second_timer = timer2.after(10) { puts "Take 10" }
# timer1.wait
# timer2.wait

## TEST call multiple procs from timer
## NOTE failed because this overwrites the 'puts "Take 5"' proc with 'puts "Take 3"'
# timers = Timers.new
# five_second_timer = timers.after(5) { puts "Take 5" }
# three_second_timer = timers.after(3) { puts "Take 3" }
# timers.wait

## TEST Schedule proc call 'after' 5 seconds on wait()
## NOTE failed because repeating 'timers.wait' with after() does NOT call proc again
# timers = Timers.new
# five_second_timer = timers.after(5) { puts "Take 5" }
# timers.wait
# timers.wait
# timers.wait

## SUCCESSFUL: Schedule proc to fire 'every' 5 seconds on wait()
# timers = Timers.new
# five_second_timer = timers.every(5) { puts "Take 5" }
# loop { timers.wait }

# = TTiimmeerrss  <<  OObbjjeecctt
# ------------------------------------------------------------------------------
# = IInncclluuddeess::
# Enumerable (from gem timers-1.1.0)
# ------------------------------------------------------------------------------
# = EExxtteennddeedd  bbyy::
# Forwardable (from gem timers-1.1.0)

# (from gem timers-1.1.0)
# ------------------------------------------------------------------------------
# Low precision timers implemented in pure Ruby

# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::
# VERSION:
#   [not documented]

# = CCllaassss  mmeetthhooddss::
#   new

# = IInnssttaannccee  mmeetthhooddss::
#   add
#   after
#   after_milliseconds
#   after_ms
#   every
#   fire
#   wait
#   wait_interval
