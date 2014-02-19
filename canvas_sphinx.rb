#!/usr/bin/ruby -w
# canvas_sphinx.rb
# Author: Andy Bettisworth
# Description: Canvas Sphinx package

## USAGE
# sudo indexer test1
# search "test"

####################
### SPHINX.CONF ###
# type = pgsql
# sql_host = localhost
# sql_port = 3306
# sql_db = sphinx_test
# sql_user = codebit
# sql_pass = trichoderma

# strip_html = 0
# index_html_attrs = img=alt,title; a=title;

# sql_query_pre = SET CHARACTER_SET_RESULTS=utf-8
# sql_query = \
#   SELECT \
#     id, \
#     group_id, \
#     UNIX_TIMESTAMP(date_added) AS date_added, \
#     title, \
#     content \
#   FROM documents
# sql_query_range = SELECT MIN(id),MAX(id) FROM documents
# sql_range_step = 1000

# sql_group_column = group_id
# sql_group_column = author_id
# sql_date_column = added_ts
# sql_str2ordinal_column = author_name

# sql_query_post = DROP TABLE my_tmp_table
# sql_query_post_index = REPLACE INTO counters ( id, val ) \
#     VALUES ( 'max_indexed_id', $maxid )
# sql_query_info = SELECT * FROM documents WHERE id=$id

# xmlpipe_command = cat @CONFDIR@/test.xml
# xmlpipe_command = cat /home/sphinx/test.xml

### SPHINX.CONF ###
####################

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

## INDEXING PROCESS
# connection to the database is established;
# pre-query  is executed to perform any necessary initial setup;
# main query is executed and the rows it returns are indexed;
# post-query is executed to perform any necessary cleanup;
# connection to the database is closed;
# indexer does the sorting phase (index-type specific post-processing);
# connection to the database is established again;
# post-index query is executed to perform any necessary final cleanup;
# connection to the database is closed again.

## SOURCES
# [database, text, HTML, mailboxes, etc...]
# There can be as many sources per index as necessary.
# Sequentially processed in order specifed.
# Merged as if they were coming from a single source.

## ATTRIBUTES
# Sort news search results by date and then relevance.
# Search products within specified price range.
# Limit blog search to posts made by selected users.
# Group results by month.

## CONFIGURATION
# Sphinx uses a configuration file.
#   vi /etc/sphinxsearch/sphinx.conf
# The conf file consists out of four parts:
#   source: data source definition
#   index: index settings for your data source
#   indexer: consists of indexer settings (cause path, charset and so on)
#   searchd: searchd settings

## SOFTWARE
# indexer: an utility which creates fulltext indexes;
# search: a simple command-line (CLI) test utility
  # which searches through fulltext indexes;
# searchd: a daemon which enables external software
  # (eg. Web applications) to search through fulltext indexes;
# sphinxapi: a set of searchd client API libraries
  # for popular Web scripting languages (PHP, Python, Perl, Ruby).

## INSTALL
# sudo cat <<-EOF > /tmp/sphinx.list;
# ## Sphinx packages
# deb http://ppa.launchpad.net/builds/sphinxsearch-beta/ubuntu $PG_CODENAME main
# deb-src http://ppa.launchpad.net/builds/sphinxsearch-beta/ubuntu $PG_CODENAME main
# EOF
# sudo mv -f /tmp/sphinx.list /etc/apt/sources.list.d/sphinx.list;
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 16932B16
# sudo apt-get install sphinxsearch

## FEATURES
# high indexing speed
  # (upto 10 MB/sec on modern CPUs);
# high search speed
  # (avg query is under 0.1 sec on 2-4 GB text collections);
# high scalability
  # (upto 100 GB of text, upto 100 M documents on a single CPU);
# provides good relevance ranking
  # through combination of phrase proximity ranking and statistical (BM25) ranking;
# provides distributed searching capabilities;
# provides document exceprts generation;
# provides searching from within MySQL through pluggable storage engine;
# supports boolean, phrase, and word proximity queries;
# supports multiple full-text fields per document (upto 32 by default);
# supports multiple additional attributes per document (ie. groups, timestamps, etc);
# supports stopwords;
# supports both single-byte encodings and UTF-8;
# supports English stemming, Russian stemming, and Soundex for morphology;
# supports MySQL natively (MyISAM and InnoDB tables are both supported);
# supports PostgreSQL natively.

## VALUE-ADD
# Sphinx is blindingly fast (even with very large datasets),
# it can sort by relevance,
# and it can sort across ActiveRecord models.

## CREDIBILITY
# Craigslist uses it.
