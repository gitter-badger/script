#!/usr/bin/env ruby -w
# formatter_spec.rb
# Description: clean your code

## > canvas File, Regex, & .gsub()
## > use github.com/airbnb/ruby style guide

## INDENTATION
# Use soft-tabs with a two space-indent.
# Indent 'when' as deep as 'case'.
# Prefer max 4 arguments.
# Method arguments either all on the same line or one per line.
## INLINE
# Never leave trailing whitespace.
# Use spaces around operators; after commas, colons, and semicolons; and around { and before }.
# No spaces after (, [ or before ], ).
## NEWLINES
# Add a new line after 'if' conditions that span multiple lines
  # to help differentiate between the conditions and the body.
## LINE LENGTH
# Keep lines to fewer than 80 characters.
# Composing long strings by putting strings next to each other,
  # separated by a backslash-then-newline.
# Breaking long logical statements with linebreaks after operators like && and ||
## COMMENTS
# Never leave commented-out code in our codebase.
# Every method declaration should have comments immediately preceding it
# that describe what the method does and how to use it. unless it meets all of the following criteria:
#   not externally visible
#   very short
#   obvious
## GRAMMAR
# Pay attention to punctuation, spelling, and grammar;
## METHODS
# Use def with parentheses when there are arguments.
# Omit the parentheses when the method doesn't accept any arguments.
# Do not use default arguments. Use an options hash instead.
# Use parentheses for a method call:
  # If the method returns a value.
  # If the first argument to the method uses parentheses.
  # Never put a space between a method name and the opening parenthesis.
# Omit parentheses for a method call:
  # If the method accepts no arguments.
  # If the method doesn't return a value (or we don't care about the return).
# In either case:
  # If a method accepts an options hash as the last argument, do not use { } during invocation.
## CONDITIONALS
# Never use 'then' for multi-line if/unless.
# The and/or keywords are banned. Always use && and || instead.
# Never use 'unless' with 'else'. Rewrite these with the positive case first.
# Avoid unless with multiple conditions.
# Don't use parentheses around the condition of an if/unless/while,
#   unless the condition contains an assignment (see Using the return value of = below).
## TERNARY OPERATOR
# Avoid the ternary operator (?:)
#   except in cases where all expressions are extremely trivial.
#   and over if/then/else/end constructs for single line conditionals.
#   Use one expression per branch in a ternary operator.
#   Avoid multi-line ?: (the ternary operator), use if/unless instead.
## SYNTAX
# Never use 'for' loops
# Prefer {...} over do...end for single-line block.
# Avoid return where not required.
# Use ||= freely to initialize variables.
# Don't use ||= to initialize boolean variables.
# Avoid using Perl-style special variables (like $0-9, $, etc. )
# When a method block takes only one argument,
#   and the body consists solely of reading an attribute
#   or calling one method with no arguments, use the &: shorthand.
## NAMING
# Use snake_case for methods and variables.
# Use CamelCase for classes and modules. (Keep acronyms like HTTP, RFC, XML uppercase.)
# Use SCREAMING_SNAKE_CASE for constants.
# The names of predicate methods (methods that return a boolean value) should end in a question mark.
# The names of potentially "dangerous" methods (i.e. methods that modify self or the arguments, exit!, etc.)
  # should end with an exclamation mark. Bang methods should only exist if a non-bang method exists.
## CLASSES
# Avoid the usage of class (@@) variables due to their "nasty" behavior in inheritance.
# Use def self.method to define singleton methods.
# Avoid class << self except when necessary, e.g. single accessors and aliased attributes.
# Indent the public, protected, and private methods as much as the method definitions they apply to.
  # Leave one blank line above them.
## EXCEPTIONS
# Don't use exceptions for flow of control.
# Avoid rescuing the Exception class.
## COLLECTIONS
# Use Set instead of Array when dealing with unique elements.
# Use symbols instead of strings as hash keys.
# Use multi-line hashes when it makes the code more readable,
## STRINGS
# Prefer string interpolation instead of string concatenation:
# Avoid using String#+ when you need to construct large data chunks.
## PERCENT LITERALS
# Use %w freely.
# Use %() for single-line strings which require both interpolation and embedded double-quotes.
# For multi-line strings, prefer heredocs.
# Use %r only for regular expressions matching more than one '/' character.
## RENDER
# When immediately returning after calling render or redirect_to,
#   put return on the next line, not the same line.

## USAGE
# format FILE
# format --template ~/.rbtemplate/css_format .

describe Formatter do
  context "with defualt template" do
    describe "#format" do
      it "should apply the default template to file"
      it "should apply the default template to all files in directory"
    end
  end

  context "with custom template" do
    describe "#format" do
      it "should apply the custom template to file"
      it "should apply the custom template to all files in directory"
    end
  end
end
