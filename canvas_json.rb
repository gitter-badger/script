#!/usr/bin/ruby -w
# json_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas JSON class

## JavaScript Object Notation

# JSON is a lightweight data-interchange format. It is easy for us humans to
# read and write. Plus, equally simple for machines to generate or parse. JSON
# is completely language agnostic, making it the ideal interchange format.

# Built on two universally available structures:
#   1. HASH - a collection of name/value pairs.
#   2. ARRAY - an ordered list of values.

# To read more about JSON visit: http://json.org

# # Parsing JSON
# To parse a JSON string received by another application or generated within
# your existing application:

#   require 'json'

#   my_hash = JSON.parse('{"hello": "goodbye"}')
#   puts my_hash["hello"] => "goodbye"

# Notice the extra quotes '' around the hash notation. Ruby expects the argument
# to be a string and can't convert objects like a hash or array.

# Ruby converts your string into a hash

###################
### CREATE JSON ###
  # require 'json'

  # my_hash = {hello: "goodbye"}
  # puts JSON.generate(my_hash)
  #=> {"hello":"goodbye"}

## Or an alternative way:
  # result = {hello: "goodbye"}.to_json
  # puts result
  #=> "{\"hello\":\"goodbye\"}"

## Error
  # puts {hello: "goodbye"}.to_json
#=> canvas_json.rb:46: syntax error, unexpected ':', expecting '}'
#=>   puts {hello: "goodbye"}.to_json

### CREATE JSON ###
###################

# JSON.generate only allows objects or arrays to be converted to JSON syntax.
# to_json, however, accepts many Ruby classes even though it acts only as a
# method for serialization:

#   require 'json'

#   1.to_json => "1"

# ------------------------------------------------------------------------------
# # Constants
# Infinity:
#   [not documented]

# JSON_LOADED:
#   [not documented]

# MinusInfinity:
#   [not documented]

# NaN:
#   [not documented]

# UnparserError:
#   This exception is raised if a generator or unparser error occurs.

# VERSION:
#   JSON version


# # Class Methods
#   const_defined_in?
#   create_id
#   dump_default_options
#   generator
#   iconv
#   load_default_options
#   parser
#   restore
#   state

# = IInnssttaannccee  mmeetthhooddss::

#   []
#   dump
#   fast_generate
#   generate
#   load
#   parse
#   parse!
#   pretty_generate
#   recurse_proc
#   restore

# # Attributes
#   attr_accessor create_id
#   attr_accessor dump_default_options
#   attr_accessor load_default_options
#   attr_accessor state
#   attr_reader generator
#   attr_reader parser

# (from gem json-1.8.1)
# ------------------------------------------------------------------------------
# # JavaScript Object Notation
# JSON is a lightweight data-interchange format. It is easy for us humans to
# read and write. Plus, equally simple for machines to generate or parse. JSON
# is completely language agnostic, making it the ideal interchange format.

# Built on two universally available structures:
#   1. A collection of name/value pairs. Often referred to as an _object_, hash table, record, struct, keyed list, or associative array.
#   2. An ordered list of values. More commonly called an _array_, vector, sequence or list.

# To read more about JSON visit: http://json.org

####################
### Parsing JSON ###
## To parse a JSON string

  # require 'json'

  # my_hash = JSON.parse('{"hello": "goodbye"}')
  # puts my_hash["hello"]
  #=> "goodbye"

## Notice the extra quotes '' around the hash notation.
## Ruby expects the argument to be a string

### Parsing JSON ###
####################

# JSON.generate only allows objects or arrays to be converted to JSON syntax.
# to_json, however, accepts many Ruby classes even though it acts only as a
# method for serialization:

#   require 'json'
#   1.to_json => "1"

# ------------------------------------------------------------------------------
# # Constants:
# Infinity:
#   [not documented]

# JSON_LOADED:
#   [not documented]

# MinusInfinity:
#   [not documented]

# NaN:
#   [not documented]

# UnparserError:
#   This exception is raised if a generator or unparser error occurs.

# VERSION:
#   JSON version

# # Class Methods
#   const_defined_in?
#   create_id
#   dump_default_options
#   generator
#   iconv
#   load_default_options
#   parser
#   restore
#   state
#   valid_utf8?

## Instance Methods
#   []
#   dump
#   fast_generate
#   generate
#   load
#   parse
#   parse!
#   pretty_generate
#   recurse_proc
#   restore
#   valid_utf8?

## Attributes:
#   attr_accessor create_id
#   attr_accessor dump_default_options
#   attr_accessor load_default_options
#   attr_accessor state
#   attr_reader generator
#   attr_reader parser
