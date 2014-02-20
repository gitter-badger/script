#!/usr/bin/ruby -w
# canvas_activemodel_attributemethods.rb
# Author: Andy Bettisworth
# Description: Canvas ActiveModel::AttributeMethods class

# = AAccttiivveeMMooddeell::::AAttttrriibbuutteeMMeetthhooddss

# ------------------------------------------------------------------------------
# = EExxtteennddeedd  bbyy::
# ActiveSupport::Concern (from gem activemodel-4.0.2)

# (from gem activemodel-4.0.2)
# ------------------------------------------------------------------------------
# == AAccttiivvee  MMooddeell  AAttttrriibbuuttee  MMeetthhooddss

# ActiveModel::AttributeMethods provides a way to add prefixes and suffixes to
# your methods as well as handling the creation of ActiveRecord::Base-like class
# methods such as table_name.

# The requirements to implement ActiveModel::AttributeMethods are to:

# * include ActiveModel::AttributeMethods in your class.
# * Call each of its method you want to add, such as attribute_method_suffix or
#   attribute_method_prefix.
# * Call define_attribute_methods after the other methods are called.
# * Define the various generic _attribute methods that you have declared.
# * Define an attributes method, see below.

# A minimal implementation could be:

#   class Person
#     include ActiveModel::AttributeMethods

#     attribute_method_affix  prefix: 'reset_', suffix: '_to_default!'
#     attribute_method_suffix '_contrived?'
#     attribute_method_prefix 'clear_'
#     define_attribute_methods :name

#     attr_accessor :name

#     def attributes
#       {'name' => @name}
#     end

#     private

#     def attribute_contrived?(attr)
#       true
#     end

#     def clear_attribute(attr)
#       send("#{attr}=", nil)
#     end

#     def reset_attribute_to_default!(attr)
#       send("#{attr}=", 'Default Name')
#     end
#   end

# Note that whenever you include ActiveModel::AttributeMethods in your class, it
# requires you to implement an attributes method which returns a hash with each
# attribute name in your model as hash key and the attribute value as hash
# value.

# Hash keys must be strings.
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::

# CALL_COMPILABLE_REGEXP:
#   [not documented]

# NAME_COMPILABLE_REGEXP:
#   [not documented]


# = IInnssttaannccee  mmeetthhooddss::

#   attribute_missing
#   match_attribute_method?
#   method_missing
#   missing_attribute
#   respond_to?
#   respond_to_without_attributes?
