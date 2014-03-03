#!/usr/bin/env ruby -w
# canvas_fileutils.rb
# Author: Andy Bettisworth
# Description: Canvas File fileutils gem

require 'fileutils'

## DELETE directory

## CREATE directory
# dirname = File.dirname(some_path)
# unless File.directory?(dirname)
#   FileUtils.mkdir_p(dirname)
# end

# FileUtils
# ------------------------------------------------------------------------------
# Includes:
# StreamUtils_ (from ruby core)

# ------------------------------------------------------------------------------
# Extended by:
# StreamUtils_ (from ruby core)

# (from ruby core)
# ------------------------------------------------------------------------------
# fileutils.rb

# Copyright (c) 2000-2007 Minero Aoki

# This program is free software. You can distribute/modify this program under
# the same terms of ruby.

# ## module FileUtils

# Namespace for several file utility methods for copying, moving, removing, etc.

# ## Module Functions

#   cd(dir, options)
#   cd(dir, options) {|dir| .... }
#   pwd()
#   mkdir(dir, options)
#   mkdir(list, options)
#   mkdir_p(dir, options)
#   mkdir_p(list, options)
#   rmdir(dir, options)
#   rmdir(list, options)
#   ln(old, new, options)
#   ln(list, destdir, options)
#   ln_s(old, new, options)
#   ln_s(list, destdir, options)
#   ln_sf(src, dest, options)
#   cp(src, dest, options)
#   cp(list, dir, options)
#   cp_r(src, dest, options)
#   cp_r(list, dir, options)
#   mv(src, dest, options)
#   mv(list, dir, options)
#   rm(list, options)
#   rm_r(list, options)
#   rm_rf(list, options)
#   install(src, dest, mode = <src's>, options)
#   chmod(mode, list, options)
#   chmod_R(mode, list, options)
#   chown(user, group, list, options)
#   chown_R(user, group, list, options)
#   touch(list, options)

# The options parameter is a hash of options, taken from the list :force, :noop,
# :preserve, and :verbose. :noop means that no changes are made.  The other two
# are obvious. Each method documents the options that it honours.

# All methods that have the concept of a "source" file or directory can take
# either one file or a list of files in that argument.  See the method
# documentation for examples.

# There are some `low level' methods, which do not accept any option:

#   copy_entry(src, dest, preserve = false, dereference = false)
#   copy_file(src, dest, preserve = false, dereference = true)
#   copy_stream(srcstream, deststream)
#   remove_entry(path, force = false)
#   remove_entry_secure(path, force = false)
#   remove_file(path, force = false)
#   compare_file(path_a, path_b)
#   compare_stream(stream_a, stream_b)
#   uptodate?(file, cmp_list)

# == mmoodduullee  FFiilleeUUttiillss::::VVeerrbboossee

# This module has all methods of FileUtils module, but it outputs messages
# before acting.  This equates to passing the :verbose flag to methods in
# FileUtils.

# == mmoodduullee  FFiilleeUUttiillss::::NNooWWrriittee

# This module has all methods of FileUtils module, but never changes
# files/directories.  This equates to passing the :noop flag to methods in
# FileUtils.

# == mmoodduullee  FFiilleeUUttiillss::::DDrryyRRuunn

# This module has all methods of FileUtils module, but never changes
# files/directories.  This equates to passing the :noop and :verbose flags to
# methods in FileUtils.


# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::

# LN_SUPPORTED:
#   [not documented]

# LOW_METHODS:
#   [not documented]

# METHODS:
#   [not documented]

# RUBY:
#   Path to the currently running Ruby program


# = CCllaassss  mmeetthhooddss::

#   cd
#   chdir
#   chmod
#   chmod_R
#   chown
#   chown_R
#   cmp
#   collect_method
#   commands
#   compare_file
#   compare_stream
#   copy
#   copy_entry
#   copy_file
#   copy_stream
#   cp
#   cp_r
#   getwd
#   have_option?
#   identical?
#   install
#   link
#   ln
#   ln_s
#   ln_sf
#   makedirs
#   mkdir
#   mkdir_p
#   mkpath
#   move
#   mv
#   options
#   options_of
#   pwd
#   remove
#   remove_dir
#   remove_entry
#   remove_entry_secure
#   remove_file
#   rm
#   rm_f
#   rm_r
#   rm_rf
#   rmdir
#   rmtree
#   safe_unlink
#   symlink
#   touch
#   uptodate?

# = IInnssttaannccee  mmeetthhooddss::

#   apply_mask
#   cd
#   chdir
#   chmod
#   chmod_R
#   chown
#   chown_R
#   cmp
#   compare_file
#   compare_stream
#   copy
#   copy_entry
#   copy_file
#   copy_stream
#   cp
#   cp_r
#   getwd
#   identical?
#   install
#   link
#   ln
#   ln_s
#   ln_sf
#   makedirs
#   mkdir
#   mkdir_p
#   mkpath
#   move
#   mv
#   pwd
#   remove
#   remove_dir
#   remove_entry
#   remove_entry_secure
#   remove_file
#   remove_tailing_slash
#   rm
#   rm_f
#   rm_r
#   rm_rf
#   rmdir
#   rmtree
#   ruby
#   safe_ln
#   safe_unlink
#   sh
#   split_all
#   symlink
#   touch
#   uptodate?

# (from gem rake-10.1.1)
# ------------------------------------------------------------------------------
# ## Constants

# LN_SUPPORTED:
#   [not documented]

# RUBY:
#   Path to the currently running Ruby program


# ## Instance methods

#   ruby
#   safe_ln
#   sh
#   split_all

