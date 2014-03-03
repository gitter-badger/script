#!/usr/bin/ruby -w
# canvas_thinking_sphinx.rb
# Author: Andy Bettisworth
# Description: Canvas ThinkingSphinx gem

# Q: thinking_sphinx with postgresql

## BASIC SETUP
# [1] Install both Sphinx and Thinking Sphinx
# [2] Create index on model (e.g app/indices/article_index.rb)
# [3] Index data 'rake ts:index'
# [4] Start sphinx server 'rake ts:start'
# [5] Call 'search()' method on indexed models

## RAKE tasks
# rake ts:clear      # Clear out Sphinx files
# rake ts:configure  # Generate the Sphinx configuration file
# rake ts:generate   # Generate fresh index files for real-time indices
# rake ts:index      # Generate the Sphinx configuration file and process all indices
# rake ts:rebuild    # Stop Sphinx, index and then restart Sphinx
# rake ts:regenerate # Stop Sphinx, clear files, reconfigure, start Sphinx, generate files
# rake ts:restart    # Restart the Sphinx daemon
# rake ts:start      # Start the Sphinx daemon
# rake ts:stop       # Stop the Sphinx daemon

## TERMS
# Fields - are the textual document contents that get indexed by Sphinx
#   and can be quickly searched for keywords.
# Attributes - are additional values associated with each document
#   that can be used to perform additional filtering and sorting.
# Reserved words - 'id' && 'name' are usable as symbols ':id' && ':name'

## ADVANCED USAGE
#  Advanced Sphinx Configuration
#  Common Questions and Issues
#  Delta Indexes
#  Facets
#  Excerpts
#  Geo-Searching
#  Sphinx Scopes
#  Deployment
#  Contributing to Thinking Sphinx

## ADVANCED SPHINX CONFIGURATION
# LINK http://www.sphinxsearch.com/docs/current.html#confgroup-index
#
# environment:
#   indices_location: "/var/www/latest_web20_craze/shared/sphinx"
#   log: "RAILS_ROOT/log/searchd.log"
#   query_log: "RAILS_ROOT/log/searchd.query.log"
#   pid_file: "RAILS_ROOT/log/searchd.ENVIRONMENT.pid"
#   address: 10.0.0.4
#   mysql41: 3200
#   mem_limit: 128M
#   morphology: stem_en
#   enable_star: true
#   min_infix_len: 3 ~OR~ min_prefix_len: 3
#   charset_type: sbcs
#   charset_table: "0..9, A..Z->a..z, _, a..z, U+410..U+42F->U+430..U+44F, U+430..U+44F"
#   max_matches: 10000
#   wordforms: "/full/path/to/wordforms.txt"
#   exceptions: "/full/path/to/exceptions.txt"
#   stopwords: "/full/path/to/stopwords.txt"
#


## Field Conditions
# Article.search 'pancakes'
# Article.search Riddle::Query.escape(params[:query])
# Article.search conditions: { subject: 'pancakes' }
# Article.search 'pancakes', conditions: { subject: 'tasty' }

## Attribute Filters
# Article.search 'pancakes', with: { author_id: @pat.id }
# Article.search 'pancakes', with: {
#   created_at: 1.week.ago..Time.now,
#   author_id: @fab_four.collect { |author| author.id }
# }
# Article.search 'pancakes',
#   :conditions => {:subject => 'tasty'},
#   :with       => {:created_at => 1.week.ago..Time.now}
# Article.search 'pancakes',
#   :without => {:user_id => current_user.id}
# Article.search 'pancakes',
#   :with_all => {:tag_ids => @tags.collect(&:id)}
# Article.search 'pancakes',
#   :with_all => {:tag_ids => [[1,2], 3]}

## Application-wide Search
# ThinkingSphinx.search 'pancakes'
# ThinkingSphinx.search 'pancakes', :classes => [Article, Comment]

## Pagination (native)
# Article.search 'pancakes', :page => params[:page], :per_page => 42

## Pagination (will_paginate gem)
# @articles = Article.search 'pancakes'
# will_paginate @articles

## Ranking Modes
# > LINK http://pat.github.io/thinking-sphinx/searching.html
