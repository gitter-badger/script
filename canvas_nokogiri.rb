#!/usr/bin/ruby -w
# canvas_nokogiri.rb
# Author: Andy Bettisworth
# Description: Canvas nokogiri gem

#############################
### PROBLEM: extract '33' ###
# require 'nokogiri'
# require 'open-uri'

# url = "https://github.com/wurde/"
# doc = Nokogiri::HTML(open(url))
# puts doc.at_css("title").text

# <div id="contribution-activity-listing">
#   <div class="inner">
#     <strong>
#       33
#     </strong>
#   </div>
# </div>
## SOLUTION:
# puts doc.at_css("div#contribution-activity-listing strong").text.to_i
### PROBLEM: extract '33' ###
#############################

# require 'nokogiri'
# require 'open-uri'

# ## GET total github commit count
# github_url = "https://github.com/wurde/"
# github_doc = Nokogiri::HTML(open(github_url))
# puts @commit_count = github_doc.at_css("div#contribution-activity-listing strong").text.to_i

# ## GET public repository count
# github_profile = Nokogiri::HTML(open("https://api.github.com/users/wurde"))
# puts @repository_count = /"public_repos":(\d+),/.match(github_profile)[1].to_i

# ## GET stackoverflow reputation && badge count
# stackoverflow_url = "http://stackoverflow.com/users/1107211/wurde"
# stackoverflow_doc = Nokogiri::HTML(open(stackoverflow_url))
# puts @reputation_count = stackoverflow_doc.at_css("div.reputation a").text.to_i
# puts @badge_count = stackoverflow_doc.at_css("span.badgecount").text.to_i

# ## GET rubygems version number and total_downloads
# rubygems_url = "http://rubygems.org/gems/tribe_triage"
# rubygems_doc = Nokogiri::HTML(open(rubygems_url))
# puts @version = rubygems_doc.at_css("div.title h3").text
# puts @total_downloads = rubygems_doc.at_css("div.downloads strong").text.to_i

############
### RDoc ###
# Nokogiri parses and searches XML/HTML very quickly, and also has correctly
# implemented CSS3 selector support as well as XPath support.

# Parsing a document returns either a Nokogiri::XML::Document, or a
# Nokogiri::HTML::Document depending on the kind of document you parse.

# Here is an example:

#   require 'nokogiri'
#   require 'open-uri'

#   # Get a Nokogiri::HTML:Document for the page we’re interested in...

#   doc = Nokogiri::HTML(open('http://www.google.com/search?q=tenderlove'))

#   # Do funky things with it using Nokogiri::XML::Node methods...

#   ####
#   # Search for nodes by css
#   doc.css('h3.r a.l').each do |link|
#     puts link.content
#   end

# See Nokogiri::XML::Node#css for more information about CSS searching. See
# Nokogiri::XML::Node#xpath for more information about XPath searching.

# = Instance Methods
#   HTML
#   Slop
#   XML
#   XSLT
#   make
#   parse
### RDoc ###
############
