#!/usr/bin/env ruby -w
# datatype_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas datatypes

PRIMITIVE
  binary
  boolean['TrueClass','FalseClass']
  character
  double
  decimal
  float['Float']
  integer['Numeric','Rational','Integer','Fixnum','Bignum']
  enumerator['Enumerator']

COMPOSITE
  array['Array']
  record
  union

ABSTRACT
  string['String']
  symbol['Symbol']
  hash['Hash']
  range['Range']
  queue['Queue']
  regex['Regexp']
  json['JSON']
  nil['NilClass']
  date['Date']
  datetime['DateTime']
  time['Time']
  timestamp
  tree
  directory['Dir']
  file['File']
<<<<<<< HEAD
  procedure['Proc']
=======
  procedure['Proc']
>>>>>>> 009a0d805c565cd30f9a7283bd8c85cae0bb8209
