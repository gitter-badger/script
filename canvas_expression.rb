# expression_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas expressions (input/output)

# OPERATOR
#   arithmetic['+','-','*','/','%','**']
#   assignment['=','||=','+=','-=','*=','**=','/=']
#   comparison['==','!=','>','<','>=','<=','<=>','===','.eql?','equal?']
#   logical['and','or','&&','||','!','not']
#   ternary['? :']
#   range['..','...']
#   scope
#     local
#     $global
#     @instance['#']
#     @@class['::']

# CONTROL
#   conditional['if','unless','case']
#   loop['while','until','for','.times','.each','.each_with_index','.foreach']
#     ['break','redo','next','retry']
#   exceptions['raise','begin rescue ensure']
#   output['return']

# METHOD
#   constructor['def end','lambda { |x| x*2 }','Proc.new()',
#     '.clone','.to_proc','alias','alias_method']
#   argument['.method(args)','method "args"',"method arg1: 'v1', arg2: 'v2'"
#     ".method(value='default', arr=[])",'.arity']
#   call['.call']
#   ['self','super','yield','bind']
#   introspection['.inspect','.hash','.name','.owner','.parameters',
#     '.receiver','source_location']
#   destructor['unbind']


###############
### GOTCHAS ###
## Convention: use only '&& ||' logical operators
# surprise = true and false
  #=> surprise is true
# surprise = true && false
  #=> surprise is false
## NOTE how 'and' differs from '&&'
# (surprise = true) and false #=> surprise is true
# surprise = (true && false)  #=> surprise is false
## LINK http://stackoverflow.com/questions/2083112/difference-between-or-and-in-ruby

## Convention: use only '=='
# 1 == 1.0   # => true
# 1.eql? 1.0 # => false
## LINK http://stackoverflow.com/questions/7156955/whats-the-difference-between-equal-eql-and

# super (without parentheses) will call parent method with exactly the same arguments that were passed to the original method
# super() (with parentheses) will call parent method without any arguments

## Convention:
# When defining your own exception class, inherit from StandardError or any of its descendants (the more specific, the better). Never use Exception for the parent.
# Never rescue Exception. If you want to do some general rescue, leave rescue statement empty (or use rescue => e to access the error).
## LINK http://stackoverflow.com/questions/10048173/why-is-it-bad-style-to-rescue-exception-e-in-ruby

## Convention: Never depend on built-in bang! methods return value,
#             e.g. in conditional statements or in control flow
#             most do nothing when they do nothing.
# 'foo'.upcase! #=> "FOO"
# 'FOO'.upcase! #=> nil

## Convention: Always use longer, more verbose version with classes wrapped by modules
# module Foo
#   class Bar
#   end
# end
## ~NOT~
# class Foo::Bar
#   def scope2
#     puts MY_SCOPE
#   end
# end
## LINK http://stackoverflow.com/questions/15119724/ruby-lexical-scope-vs-inheritance

## Convention: Never rely on anything that happens inside assignment method,
#              eg. in conditional statements like this:
# class Foo
#   def self.bar=(value)
#     @foo = value
#     return 'OK'
#   end
# end
# Foo.bar = 3 #=> 3

## Convention: In order to make your class method private,
#               you have to use private_class_method :method_name or
#               put your private class method inside class << self block:
# class Foo
#   class << self
#     private
#     def bar
#       puts 'Class method called'
#     end
#   end
#   def self.baz
#     puts 'Another class method called'
#   end
#   private_class_method :baz
# end
# Foo.bar #=> NoMethodError: private method `bar' called for Foo:Class
# Foo.baz #=> NoMethodError: private method `baz' called for Foo:Class

### GOTCHAS ###
###############
