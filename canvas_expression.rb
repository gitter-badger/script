# expression_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas expressions

OPERATOR
  arithmetic['+','-','*','/','%','**']
  assignment['=','||=','+=','-=','*=','**=','/=']
  comparison['==','!=','>','<','>=','<=','<=>','===','.eql?','equal?']
  logical['and','or','&&','||','!','not']
  ternary['? :']
  range['..','...']
  scope
    local
    $global
    @instance['#']
    @@class['::']

CONTROL
  conditional['if','unless','case']
  loop['while','until','for','.times','.each','.each_with_index','.foreach']
    ['break','redo','next','retry']
  exceptions['raise','begin rescue ensure']
  output['return']

METHOD
  constructor['def end','lambda { |x| x*2 }','Proc.new()',
    '.clone','.to_proc','alias','alias_method']
  argument['.method(args)','method "args"',"method arg1: 'v1', arg2: 'v2'"
    ".method(value='default', arr=[])",'.arity']
  call['.call']
  ['self','super','yield','bind']
  introspection['.inspect','.hash','.name','.owner','.parameters',
    '.receiver','source_location']
  destructor['unbind']
