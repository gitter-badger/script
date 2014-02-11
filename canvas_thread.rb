#!/usr/bin/env ruby -w
# class_thread.rb
# Description: Allows for concurrent programming (multithreading)

###
## Q: How to get raise exceptions to main thread from parallel threads
## a: By raising it ourself.
# thread1 = Thread.new do
#   puts "Multithreading it up."
#   raise "Exception from thread1!"
# end
# thread1.join
# ## => OUTPUT
# Multithreading it up.
# class_thread.rb:11:in `block in <main>': Exception from thread1! (RuntimeError)
###

###
## NOTE Threads run at priorities
## 'main' thread starts at '0' priority
## Can only set priority of a thread after its' creation
# thread1 = Thread.new do
#   puts "Current thread proirity: " + .priority.to_s
# end
# thread1.join
# puts 'priority: ' + thread1.priority.to_s
###

###
## NOTE Threads have access to variables within scope at time of creation
# count = 0
# array = []

# 10.times do |i|
#   array[i] = Thread.new {
#     sleep(rand(0)/10.0)
#     Thread.current["my_count"] = count
#     count += 1
#   }
# end

# array.each {|thread| thread.join; print thread["my_count"], ", "}
# puts "count = #{count}"
###

###
## NOTE Threads begin immediately after their creation
## so no reason to call equivalents: .new or .fork
## Example
# def method1
#   3.times do
#     puts "method1 ran at: #{Time.now}"
#     sleep(2)
#   end
# end

# def method2
#   3.times do
#     puts "method2 ran at: #{Time.now}"
#     sleep(1)
#   end
# end

# thread1 = Thread.new{method1}
# thread2 = Thread.new{method2}
# thread1.join
# thread2.join
# puts "End at #{Time.now}"

## NOTE pay attention to the seconds between calls due to 'sleep(x)'
# ## => OUTPUT
# method2 ran at: 2014-01-13 00:52:30 -0600
# method1 ran at: 2014-01-13 00:52:30 -0600
# method2 ran at: 2014-01-13 00:52:31 -0600
# method1 ran at: 2014-01-13 00:52:32 -0600
# method2 ran at: 2014-01-13 00:52:32 -0600
# method1 ran at: 2014-01-13 00:52:34 -0600
# End at 2014-01-13 00:52:36 -0600
###

###
## Thread 1 runs this code
# Thread.new {
#   ## Thread 2 runs this code
#   2.times puts 'testing'
# }
## Thread 1 runs this code
###