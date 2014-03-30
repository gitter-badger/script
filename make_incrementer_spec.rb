#!/usr/bin/ruby -w
# make_incrementer.rb
# Description: demonstrate powers of Procs

def make_incrementer(delta)
  lambda { |x| x + delta }
end

incrementer_proc_of = Hash.new
[10, 20].each do |delta|
  incrementer_proc_of[delta] = make_incrementer(delta)
end

incrementer_proc_of.each_pair do |delta, incrementer_proc|
  puts "#{delta} + 5 = #{incrementer_proc.call(5)}\n"
end
puts

incrementer_proc_of.each_pair do |delta, incrementer_proc|
  (0..5).to_a.each do |other_addend|
    puts "#{delta} + #{other_addend} = " +
    incrementer_proc.call(other_addend) + "\n"
  end
end
