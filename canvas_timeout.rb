#!/usr/bin/ruby -w
# canvas_timeout.rb
# Author: Andy Bettisworth
# Description: Canvas Timeout gem

# = TTiimmeeoouutt
# (from ruby core)
# ------------------------------------------------------------------------------
# Timeout long-running blocks

# == SSyynnooppssiiss
#   require 'timeout'
#   status = Timeout::timeout(5) {
#     # Something that should be interrupted if it takes more than 5 seconds...
#   }

# == DDeessccrriippttiioonn
# Timeout provides a way to auto-terminate a potentially long-running operation
# if it hasn't finished in a fixed amount of time.

# Previous versions didn't use a module for namespacing, however #timeout is
# provided for backwards compatibility.  You should prefer Timeout#timeout
# instead.

# == CCooppyyrriigghhtt
# Copyright:
#   (C) 2000  Network Applied Communication Laboratory, Inc.
# Copyright:
#   (C) 2000  Information-technology Promotion Agency, Japan

# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::
#   timeout

# = IInnssttaannccee  mmeetthhooddss::
#   timeout
