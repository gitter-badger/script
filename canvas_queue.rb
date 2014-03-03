# queue_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas Queue class

# # Queue < Object
# (from ruby core)
# ------------------------------------------------------------------------------
# This class provides a way to synchronize communication between threads.

# Example:
<<<<<<< HEAD

=======
>>>>>>> 009a0d805c565cd30f9a7283bd8c85cae0bb8209
#   require 'thread'
#   queue = Queue.new

#   producer = Thread.new do
#     5.times do |i|
#        sleep rand(i) # simulate expense
#        queue << i
#        puts "#{i} produced"
#     end
#   end

#   consumer = Thread.new do
#     5.times do |i|
#        value = queue.pop
#        sleep rand(i/2) # simulate expense
#        puts "consumed #{value}"
#     end
#   end
<<<<<<< HEAD
=======

>>>>>>> 009a0d805c565cd30f9a7283bd8c85cae0bb8209
# ------------------------------------------------------------------------------
# # Class Methods
#   new

# # Instance Methods
#   <<
#   clear
#   deq
#   empty?
#   enq
#   length
#   num_waiting
#   pop
#   push
#   shift
#   size
