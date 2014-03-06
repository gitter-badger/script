#!/usr/bin/ruby -w
# canvas_rspec.rb
# Author: Andy Bettisworth
# Description: Canvas RSpec gem for testing

###################
### SETUP RSpec ###
# rspec --init
# ~&&~
# [spec/../blah_spec.rb]
# require 'spec_helper'
### SETUP RSpec ###
###################

## Object predicates
#   Equality and Identity - object has values that match expectations
#     eq(expected)
#     equal(expected)
#   True/False/nil
#     be_true
#     be_false
#     be_nil
#   Numeric comparisons
#     be >= 10
#     be_within(0.01).of(28.35)
#   Regex pattern matching
#     match /a regex/
#   Array and string prefixes/suffixes
#     start_with "free"
#     start_with [1,2,3]
#     end_with "dom"
#     end_with [3,4,5]
#   Array matching
#     match_array [a,b,c]
#     match_array [b,c,a]
#   Ancestor class
#     be_a <class>
#     be_an <class>
#     be_a_kind_of <class>
#     be_an_instance_of <class>
#     be_instance_of <class>
#   Collection Size
#     have(<n>).things
#     have_at_least(<n>).things
#     have_at_most(<n>).things
#   Containment and coverage
#     expect("string").to include "str"
#     expect([1,2,3]).to include 2,1
#     expect(1..5).to cover 3,4,5
#   Duck Typing
#     respond_to(:foo)
#     respond_to(:foo, :and_bar, :and_baz)
#     respond_to(:foo).with(1).argument
#     respond_to(:foo).with(2).arguments

## Block predicates
#   Raising
#     raise_error
#     raise_error RuntimeError
#     raise_error "the exact error message"
#     raise_error /message$/
#     raise_error NameError, "exact message"
#     raise_error NameError, /error message/
#   Throwing
#     throw_symbol
#     throw_symbol :specificsymbol
#     throw_symbol :specificsymbol, with_arg
#   Yielding
#     yield_control
#     yield_with_args "match foo", /match bar/
#     yield_with_no_args
#     yield_successive_args "foo", "bar"
#   Changing
#     change{ Counter.count }
#     change{ Counter.count }.from(0).to(1)
#     change{ Counter.count }.by(2)
#   Satisfying
#     expect(20).to satisfy { |x| x % 5 == 0 }

## Mocked Behaviour
#   Mock a database connection
#     test_db = double("database")
#     test_db.should_receive(:connect).once
#     test_db.should_receive(:query).at_least(3).times.and_return(0)
#     test_db.should_receive(:close).once
#   Live call to fetch information
#     world = World.new()
#     world.stub(:get_current_state).and_return( [1,2,3,4,5] )
#   Creating a double
#     foo = double(<name>)
#     foo = double(<name>, <options>)
#     foo = double("Foo", null_object: true)
#   Expecting messages
#     double.should_receive(:<message>)
#     double.should_not_receive(:<message>)
#   Expecting arguments to messages
#     should_receive(:foo).with(<args>)
#     should_receive(:foo).with(:no_args)
#     should_receive(:foo).with(:any_args)
#   Defining explicit response of a double
#     double.should_receive(:msg) { block_here }
#   Arbitrary argument handling
#     double.should_receive(:msg) do |arg1|
#       value1 = do_something_with_argument(arg1)
#       expect(value1).to eq(42)
#     end
#   Receive counts
#     double.should_receive(:foo).once
#       .twice
#       .exactly(n).times
#       .any_number_of_times
#       .at_least(:once)
#       .at_least(:twice)
#       .at_least(n).times
#   Return values
#     should_receive(:foo).once.and_return(v)
#       .and_return(v1, v2, ..., vn)
#       .at_least(n).times
#       .and_return { ... }
#   Raising, Throwing and Yielding
#     .and_raise(<exception>)
#     .and_throw(:symbol)
#     .and_yield(values, to, yield)
#   Enforcing Ordering
#     .should_receive(:flip).once.ordered
#     .should_receive(:flop).once.ordered

## Stubs
#   Creating a Stub
#     double.stub(:stub) { "OK" }
#     double.stub(stub: "OK" )
#     double.stub(:stub).and_return("OK")
#   Double with stub at creation time
#     double("Foo", status: "OK")
#     double(status: "OK")
#   Multiple consective return values
#     die.stub(:roll).and_return(1,2,3)
#     die.roll #=> 1
#     die.roll #=> 2
#     die.roll #=> 3
#     die.roll #=> 3
#     die.roll #=> 3
#   Raising, Throwing and Yielding
#     and_raise
#     and_throw
#     and_yield

################
### Matchers ###
# include(item)
# respond_to(message)
# raise_error(type)
### Matchers ###
################

############
### Tags ###
# it "should return 'Testing 1 2 3'", wip: true do
# rspec --tag wip todo_spec.rb
### Tags ###
############

######################
### Complete Match ###
# expected = File.open('expected_statement.txt','r') do |f|
#   f.read
# end
# expect(statement).to equal(expected)
### Complete Match ###
######################

#####################
### Partial Match ###
# expect(statement).to match(/partial/)
### Partial Match ###
#####################

#########################
### Expecting a Throw ###
# course = Course.new(seats: 20)
# 20.times { course.register Student.new }
# expect(lambda { course.register Student.new }).to throw_symbol(:course_full)
### Expecting a Throw ###
#########################

## CHECK File for regex match && use interpolation
# File.new(default_list,'r').readlines.each_with_index do |line, index|
#   expect(line =~ /^#{index}\s.*/o).to eq(0)
# end

## CHECK file does not include string
# it "should delete old to-do" do
#   taskmaster.delete(task: target_task)
#   expect(File.new(default_list,'r').readlines).to_not include(target_task)
# end

## CHECK file is empty
# taskmaster.new(test_task,target_list)
# taskmaster.delete_all(task: target_task, list: target_list)
# expect(File.new(target_list,'r').readlines).to have(0).things

# [spec/spec_helper.rb]
# ## Usage "require 'spec_helper'"
#   RSpec.configure do |config|
#     config.color_enabled = true
#     config.order = "random"

#     config.formatter = "nyanCatWideFormatter"
#   end

## SET initial state within nested context()
# describe Stack do
#   context "when empty" do
#     before(:each) do
#       @stack = Stack.new
#     end
#   end

#   context "when almost empty (with one element)" do
#     before(:each) do
#       @stack = Stack.new
#       @stack.push 1
#     end
#   end

#   context "when almost full (with one element less than capacity)" do
#     before(:each) do
#       @stack = Stack.new
#       (1..9).each { |x| @stack.push x}
#     end
#   end

#   context "when full" do
#     before(:each) do
#       @stack = Stack.new
#       (1..10).each { |x| @stack.push x}
#     end
#   end
# end

## NOTE RSpec allows for nesting example groups
## so use them to write expressive tests
# describe Host do
#   describe "#tcp_sequence" do
#     subject { super().tcp_sequence }

#     it { should be_kind_of(TcpSequence) }
#   end

#   describe "#ip_ip_sequence" do
#     subject { super().ip_id_sequence }

#     it { should be_kind_of(IpIdSequence) }
#   end

#   describe "#tcp_ts_sequence" do
#     subject { super().tcp_ts_sequence }

#     it { should be_kind_of(TcpTsSequence) }
#   end
# end

## GROUP things by initial state with before(:each)
# describe Stack do
#   before(:each) do
#     @stack = Stack.new
#   end
# end

## NOTE
# context() is interchangeable with describe()
# 'pending "pair coding"' will place a code example as 'pending'
# .const_defined?('VERSION').should be_true
# use 'expect().to' && 'expect().to_not', never use '!='

#         output = double('output').as_null_object
#         game = Game.new(output)
#         output.should_receive(:puts).with('Welcome to Codebreaker!')
#         game.start
