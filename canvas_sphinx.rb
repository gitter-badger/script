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

## Command-line (indexer)
# Sphinx 2.1.6-id64-dev (rel21-r4564)
# Copyright (c) 2001-2014, Andrew Aksyonoff
# Copyright (c) 2008-2014, Sphinx Technologies Inc (http://sphinxsearch.com)
#
## Usage: indexer [OPTIONS] [indexname1 [indexname2 [...]]]
#
## Options are:
# --config <file>		read configuration from specified file
# 			(default is sphinx.conf)
# --all			reindex all configured indexes
# --quiet			be quiet, only print errors
# --verbose		verbose indexing issues report
# --noprogress		do not display progress
# 			(automatically on if output is not to a tty)
# --rotate		send SIGHUP to searchd when indexing is over
# 			to rotate updated indexes automatically
# --sighup-each		send SIGHUP to searchd after each index
# 			(used with --rotate only)
# --buildstops <output.txt> <N>
# 			build top N stopwords and write them to given file
# --buildfreqs		store words frequencies to output.txt
# 			(used with --buildstops only)
# --merge <dst-index> <src-index>
# 			merge 'src-index' into 'dst-index'
# 			'dst-index' will receive merge result
# 			'src-index' will not be modified
# --merge-dst-range <attr> <min> <max>
# 			filter 'dst-index' on merge, keep only those documents
# 			where 'attr' is between 'min' and 'max' (inclusive)
# --merge-klists
# --merge-killlists	  merge src and dst k-lists (default is to discard them
# 			after merge; note that src k-list applies anyway)
# --dump-rows <FILE>	dump indexed rows into FILE
# --print-queries		  print SQL queries (for debugging)
# --keep-attrs		    retain attributes from the old index
#
## Examples:
# indexer --quiet myidx1	reindex 'myidx1' defined in 'sphinx.conf'
# indexer --all		reindex all indexes defined in 'sphinx.conf'


############################
### ORIGINAL SPHINX.CONF ###
# #
# # Sphinx configuration file sample
# #
# # WARNING! While this sample file mentions all available options,
# # it contains (very) short helper descriptions only. Please refer to
# # doc/sphinx.html for details.
# #

# #############################################################################
# ## data source definition
# #############################################################################
#  source src1
# {
#   # data source type. mandatory, no default value
#   # known types are mysql, pgsql, mssql, xmlpipe, xmlpipe2, odbc
#   type      = mysql

#   #####################################################################
#   ## SQL settings (for 'mysql' and 'pgsql' types)
#   #####################################################################

#   # some straightforward parameters for SQL source types
#   sql_host    = localhost
#   sql_user    = test
#   sql_pass    =
#   sql_db      = sphinx_test
#   sql_port    = 3306  # optional, default is 3306

#   # UNIX socket name
#   # optional, default is empty (reuse client library defaults)
#   # usually '/var/lib/mysql/mysql.sock' on Linux
#   # usually '/tmp/mysql.sock' on FreeBSD
#   #
#   # sql_sock    = /tmp/mysql.sock


#   # MySQL specific client connection flags
#   # optional, default is 0
#   #
#   # mysql_connect_flags = 32 # enable compression

#   # MySQL specific SSL certificate settings
#   # optional, defaults are empty
#   #
#   # mysql_ssl_cert    = /etc/ssl/client-cert.pem
#   # mysql_ssl_key   = /etc/ssl/client-key.pem
#   # mysql_ssl_ca    = /etc/ssl/cacert.pem

#   # MS SQL specific Windows authentication mode flag
#   # MUST be in sync with charset_type index-level setting
#   # optional, default is 0
#   #
#   # mssql_winauth   = 1 # use currently logged on user credentials


#   # MS SQL specific Unicode indexing flag
#   # optional, default is 0 (request SBCS data)
#   #
#   # mssql_unicode   = 1 # request Unicode data from server


#   # ODBC specific DSN (data source name)
#   # mandatory for odbc source type, no default value
#   #
#   # odbc_dsn    = DBQ=C:\data;DefaultDir=C:\data;Driver={Microsoft Text Driver (*.txt; *.csv)};
#   # sql_query   = SELECT id, data FROM documents.csv


#   # ODBC and MS SQL specific, per-column buffer sizes
#   # optional, default is auto-detect
#   #
#   # sql_column_buffers  = content=12M, comments=1M


#   # pre-query, executed before the main fetch query
#   # multi-value, optional, default is empty list of queries
#   #
#   # sql_query_pre   = SET NAMES utf8
#   # sql_query_pre   = SET SESSION query_cache_type=OFF


#   # main document fetch query
#   # mandatory, integer document ID field MUST be the first selected column
#   sql_query   = \
#     SELECT id, group_id, UNIX_TIMESTAMP(date_added) AS date_added, title, content \
#     FROM documents


#   # joined/payload field fetch query
#   # joined fields let you avoid (slow) JOIN and GROUP_CONCAT
#   # payload fields let you attach custom per-keyword values (eg. for ranking)
#   #
#   # syntax is FIELD-NAME 'from'  ( 'query' | 'payload-query' ); QUERY
#   # joined field QUERY should return 2 columns (docid, text)
#   # payload field QUERY should return 3 columns (docid, keyword, weight)
#   #
#   # REQUIRES that query results are in ascending document ID order!
#   # multi-value, optional, default is empty list of queries
#   #
#   # sql_joined_field  = tags from query; SELECT docid, CONCAT('tag',tagid) FROM tags ORDER BY docid ASC
#   # sql_joined_field  = wtags from payload-query; SELECT docid, tag, tagweight FROM tags ORDER BY docid ASC


#   # file based field declaration
#   #
#   # content of this field is treated as a file name
#   # and the file gets loaded and indexed in place of a field
#   #
#   # max file size is limited by max_file_field_buffer indexer setting
#   # file IO errors are non-fatal and get reported as warnings
#   #
#   # sql_file_field    = content_file_path


#   # range query setup, query that must return min and max ID values
#   # optional, default is empty
#   #
#   # sql_query will need to reference $start and $end boundaries
#   # if using ranged query:
#   #
#   # sql_query   = \
#   # SELECT doc.id, doc.id AS group, doc.title, doc.data \
#   # FROM documents doc \
#   # WHERE id>=$start AND id<=$end
#   #
#   # sql_query_range   = SELECT MIN(id),MAX(id) FROM documents


#   # range query step
#   # optional, default is 1024
#   #
#   # sql_range_step    = 1000


#   # unsigned integer attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # optional bit size can be specified, default is 32
#   #
#   # sql_attr_uint   = author_id
#   # sql_attr_uint   = forum_id:9 # 9 bits for forum_id
#   sql_attr_uint   = group_id

#   # boolean attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # equivalent to sql_attr_uint with 1-bit size
#   #
#   # sql_attr_bool   = is_deleted


#   # bigint attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # declares a signed (unlike uint!) 64-bit attribute
#   #
#   # sql_attr_bigint   = my_bigint_id


#   # UNIX timestamp attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # similar to integer, but can also be used in date functions
#   #
#   # sql_attr_timestamp  = posted_ts
#   # sql_attr_timestamp  = last_edited_ts
#   sql_attr_timestamp  = date_added

#   # string ordinal attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # sorts strings (bytewise), and stores their indexes in the sorted list
#   # sorting by this attr is equivalent to sorting by the original strings
#   #
#   # sql_attr_str2ordinal  = author_name


#   # floating point attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # values are stored in single precision, 32-bit IEEE 754 format
#   #
#   # sql_attr_float    = lat_radians
#   # sql_attr_float    = long_radians


#   # multi-valued attribute (MVA) attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # MVA values are variable length lists of unsigned 32-bit integers
#   #
#   # syntax is ATTR-TYPE ATTR-NAME 'from' SOURCE-TYPE [;QUERY] [;RANGE-QUERY]
#   # ATTR-TYPE is 'uint' or 'timestamp'
#   # SOURCE-TYPE is 'field', 'query', or 'ranged-query'
#   # QUERY is SQL query used to fetch all ( docid, attrvalue ) pairs
#   # RANGE-QUERY is SQL query used to fetch min and max ID values, similar to 'sql_query_range'
#   #
#   # sql_attr_multi    = uint tag from query; SELECT docid, tagid FROM tags
#   # sql_attr_multi    = uint tag from ranged-query; \
#   # SELECT docid, tagid FROM tags WHERE id>=$start AND id<=$end; \
#   # SELECT MIN(docid), MAX(docid) FROM tags


#   # string attribute declaration
#   # multi-value (an arbitrary number of these is allowed), optional
#   # lets you store and retrieve strings
#   #
#   # sql_attr_string   = stitle


#   # wordcount attribute declaration
#   # multi-value (an arbitrary number of these is allowed), optional
#   # lets you count the words at indexing time
#   #
#   # sql_attr_str2wordcount  = stitle


#   # JSON attribute declaration
#   # multi-value (an arbitrary number of these is allowed), optional
#   # lets you store a JSON document as an (in-memory) attribute for later use
#   #
#   # sql_attr_json   = properties


#   # combined field plus attribute declaration (from a single column)
#   # stores column as an attribute, but also indexes it as a full-text field
#   #
#   # sql_field_string  = author
#   # sql_field_str2wordcount = title


#   # post-query, executed on sql_query completion
#   # optional, default is empty
#   #
#   # sql_query_post    =


#   # post-index-query, executed on successful indexing completion
#   # optional, default is empty
#   # $maxid expands to max document ID actually fetched from DB
#   #
#   # sql_query_post_index  = REPLACE INTO counters ( id, val ) \
#   # VALUES ( 'max_indexed_id', $maxid )


#   # ranged query throttling, in milliseconds
#   # optional, default is 0 which means no delay
#   # enforces given delay before each query step
#   sql_ranged_throttle = 0

#   # document info query, ONLY for CLI search (ie. testing and debugging)
#   # optional, default is empty
#   # must contain $id macro and must fetch the document by that id
#   sql_query_info    = SELECT * FROM documents WHERE id=$id

#   # kill-list query, fetches the document IDs for kill-list
#   # k-list will suppress matches from preceding indexes in the same query
#   # optional, default is empty
#   #
#   # sql_query_killlist  = SELECT id FROM documents WHERE edited>=@last_reindex


#   # columns to unpack on indexer side when indexing
#   # multi-value, optional, default is empty list
#   #
#   # unpack_zlib   = zlib_column
#   # unpack_mysqlcompress  = compressed_column
#   # unpack_mysqlcompress  = compressed_column_2


#   # maximum unpacked length allowed in MySQL COMPRESS() unpacker
#   # optional, default is 16M
#   #
#   # unpack_mysqlcompress_maxsize  = 16M


#   # hook command to run when SQL connection succeeds
#   # optional, default value is empty (do nothing)
#   #
#   # hook_connect      = bash sql_connect.sh


#   # hook command to run after (any) SQL range query
#   # it may print out "minid maxid" (w/o quotes) to override the range
#   # optional, default value is empty (do nothing)
#   #
#   # hook_query_range    = bash sql_query_range.sh


#   # hook command to run on successful indexing completion
#   # $maxid expands to max document ID actually fetched from DB
#   # optional, default value is empty (do nothing)
#   #
#   # hook_post_index   = bash sql_post_index.sh $maxid

#   #####################################################################
#   ## xmlpipe2 settings
#   #####################################################################

#   # type      = xmlpipe

#   # shell command to invoke xmlpipe stream producer
#   # mandatory
#   #
#   # xmlpipe_command   = cat /var/lib/sphinxsearch/test.xml

#   # xmlpipe2 field declaration
#   # multi-value, optional, default is empty
#   #
#   # xmlpipe_field   = subject
#   # xmlpipe_field   = content


#   # xmlpipe2 attribute declaration
#   # multi-value, optional, default is empty
#   # all xmlpipe_attr_XXX options are fully similar to sql_attr_XXX
#   # examples:
#   #
#   # xmlpipe_attr_timestamp  = published
#   # xmlpipe_attr_uint = author_id
#   # xmlpipe_attr_str2ordinal= author
#   # xmlpipe_attr_bool = is_enabled
#   # xmlpipe_attr_float  = latitude
#   # xmlpipe_attr_bigint = guid
#   # xmlpipe_attr_multi  = tags
#   # xmlpipe_attr_multi_64 = tags64
#   # xmlpipe_attr_string = title
#   # xmlpipe_attr_wordcount  = title_num_words
#   # xmlpipe_attr_json = extra_data
#   # xmlpipe_field_string  = content
#   # xmlpipe_field_wordcount = content_num_words


#   # perform UTF-8 validation, and filter out incorrect codes
#   # avoids XML parser choking on non-UTF-8 documents
#   # optional, default is 0
#   #
#   # xmlpipe_fixup_utf8  = 1
# }


# # inherited source example
# #
# # all the parameters are copied from the parent source,
# # and may then be overridden in this source definition
# source src1throttled : src1
# {
#   sql_ranged_throttle = 100
# }

# #############################################################################
# ## index definition
# #############################################################################

# # local index example
# #
# # this is an index which is stored locally in the filesystem
# #
# # all indexing-time options (such as morphology and charsets)
# # are configured per local index
# index test1
# {
#   # index type
#   # optional, default is 'plain'
#   # known values are 'plain', 'distributed', and 'rt' (see samples below)
#   # type      = plain

#   # document source(s) to index
#   # multi-value, mandatory
#   # document IDs must be globally unique across all sources
#   source      = src1

#   # index files path and file name, without extension
#   # mandatory, path must be writable, extensions will be auto-appended
#   path      = /var/lib/sphinxsearch/data/test1

#   # document attribute values (docinfo) storage mode
#   # optional, default is 'extern'
#   # known values are 'none', 'extern' and 'inline'
#   docinfo     = extern

#   # dictionary type, 'crc' or 'keywords'
#   # crc is faster to index when no substring/wildcards searches are needed
#   # crc with substrings might be faster to search but is much slower to index
#   # (because all substrings are pre-extracted as individual keywords)
#   # keywords is much faster to index with substrings, and index is much (3-10x) smaller
#   # keywords supports wildcards, crc does not, and never will
#   # optional, default is 'crc'
#   dict      = keywords

#   # memory locking for cached data (.spa and .spi), to prevent swapping
#   # optional, default is 0 (do not mlock)
#   # requires searchd to be run from root
#   mlock     = 0

#   # a list of morphology preprocessors to apply
#   # optional, default is empty
#   #
#   # builtin preprocessors are 'none', 'stem_en', 'stem_ru', 'stem_enru',
#   # 'soundex', and 'metaphone'; additional preprocessors available from
#   # libstemmer are 'libstemmer_XXX', where XXX is algorithm code
#   # (see libstemmer_c/libstemmer/modules.txt)
#   #
#   # morphology    = stem_en, stem_ru, soundex
#   # morphology    = libstemmer_german
#   # morphology    = libstemmer_sv
#   morphology    = none

#   # minimum word length at which to enable stemming
#   # optional, default is 1 (stem everything)
#   #
#   # min_stemming_len  = 1


#   # stopword files list (space separated)
#   # optional, default is empty
#   # contents are plain text, charset_table and stemming are both applied
#   #
#   # stopwords   = /var/lib/sphinxsearch/data/stopwords.txt


#   # wordforms file, in "mapfrom > mapto" plain text format
#   # optional, default is empty
#   #
#   # wordforms   = /var/lib/sphinxsearch/data/wordforms.txt


#   # tokenizing exceptions file
#   # optional, default is empty
#   #
#   # plain text, case sensitive, space insensitive in map-from part
#   # one "Map Several Words => ToASingleOne" entry per line
#   #
#   # exceptions    = /var/lib/sphinxsearch/data/exceptions.txt


#   # embedded file size limit
#   # optional, default is 16K
#   #
#   # exceptions, wordforms, and stopwords files smaller than this limit
#   # are stored in the index; otherwise, their paths and sizes are stored
#   #
#   # embedded_limit    = 16K

#   # minimum indexed word length
#   # default is 1 (index everything)
#   min_word_len    = 1

#   # charset encoding type
#   # optional, default is 'sbcs'
#   # known types are 'sbcs' (Single Byte CharSet) and 'utf-8'
#   charset_type    = sbcs

#   # charset definition and case folding rules "table"
#   # optional, default value depends on charset_type
#   #
#   # defaults are configured to include English and Russian characters only
#   # you need to change the table to include additional ones
#   # this behavior MAY change in future versions
#   #
#   # 'sbcs' default value is
#   # charset_table   = 0..9, A..Z->a..z, _, a..z, U+A8->U+B8, U+B8, U+C0..U+DF->U+E0..U+FF, U+E0..U+FF
#   #
#   # 'utf-8' default value is
#   # charset_table   = 0..9, A..Z->a..z, _, a..z, U+410..U+42F->U+430..U+44F, U+430..U+44F


#   # ignored characters list
#   # optional, default value is empty
#   #
#   # ignore_chars    = U+00AD


#   # minimum word prefix length to index
#   # optional, default is 0 (do not index prefixes)
#   #
#   # min_prefix_len    = 0


#   # minimum word infix length to index
#   # optional, default is 0 (do not index infixes)
#   #
#   # min_infix_len   = 0


#   # maximum substring (prefix or infix) length to index
#   # optional, default is 0 (do not limit substring length)
#   #
#   # max_substring_len = 8


#   # list of fields to limit prefix/infix indexing to
#   # optional, default value is empty (index all fields in prefix/infix mode)
#   #
#   # prefix_fields   = filename
#   # infix_fields    = url, domain


#   # enable star-syntax (wildcards) when searching prefix/infix indexes
#   # search-time only, does not affect indexing, can be 0 or 1
#   # optional, default is 0 (do not use wildcard syntax)
#   #
#   # enable_star   = 1


#   # expand keywords with exact forms and/or stars when searching fit indexes
#   # search-time only, does not affect indexing, can be 0 or 1
#   # optional, default is 0 (do not expand keywords)
#   #
#   # expand_keywords   = 1


#   # n-gram length to index, for CJK indexing
#   # only supports 0 and 1 for now, other lengths to be implemented
#   # optional, default is 0 (disable n-grams)
#   #
#   # ngram_len   = 1


#   # n-gram characters list, for CJK indexing
#   # optional, default is empty
#   #
#   # ngram_chars   = U+3000..U+2FA1F


#   # phrase boundary characters list
#   # optional, default is empty
#   #
#   # phrase_boundary   = ., ?, !, U+2026 # horizontal ellipsis


#   # phrase boundary word position increment
#   # optional, default is 0
#   #
#   # phrase_boundary_step  = 100


#   # blended characters list
#   # blended chars are indexed both as separators and valid characters
#   # for instance, AT&T will results in 3 tokens ("at", "t", and "at&t")
#   # optional, default is empty
#   #
#   # blend_chars   = +, &, U+23


#   # blended token indexing mode
#   # a comma separated list of blended token indexing variants
#   # known variants are trim_none, trim_head, trim_tail, trim_both, skip_pure
#   # optional, default is trim_none
#   #
#   # blend_mode    = trim_tail, skip_pure


#   # whether to strip HTML tags from incoming documents
#   # known values are 0 (do not strip) and 1 (do strip)
#   # optional, default is 0
#   html_strip    = 0

#   # what HTML attributes to index if stripping HTML
#   # optional, default is empty (do not index anything)
#   #
#   # html_index_attrs  = img=alt,title; a=title;


#   # what HTML elements contents to strip
#   # optional, default is empty (do not strip element contents)
#   #
#   # html_remove_elements  = style, script


#   # whether to preopen index data files on startup
#   # optional, default is 0 (do not preopen), searchd-only
#   #
#   # preopen     = 1


#   # whether to keep dictionary (.spi) on disk, or cache it in RAM
#   # optional, default is 0 (cache in RAM), searchd-only
#   #
#   # ondisk_dict   = 1


#   # whether to enable in-place inversion (2x less disk, 90-95% speed)
#   # optional, default is 0 (use separate temporary files), indexer-only
#   #
#   # inplace_enable    = 1


#   # in-place fine-tuning options
#   # optional, defaults are listed below
#   #
#   # inplace_hit_gap   = 0 # preallocated hitlist gap size
#   # inplace_docinfo_gap = 0 # preallocated docinfo gap size
#   # inplace_reloc_factor  = 0.1 # relocation buffer size within arena
#   # inplace_write_factor  = 0.1 # write buffer size within arena


#   # whether to index original keywords along with stemmed versions
#   # enables "=exactform" operator to work
#   # optional, default is 0
#   #
#   # index_exact_words = 1


#   # position increment on overshort (less that min_word_len) words
#   # optional, allowed values are 0 and 1, default is 1
#   #
#   # overshort_step    = 1


#   # position increment on stopword
#   # optional, allowed values are 0 and 1, default is 1
#   #
#   # stopword_step   = 1


#   # hitless words list
#   # positions for these keywords will not be stored in the index
#   # optional, allowed values are 'all', or a list file name
#   #
#   # hitless_words   = all
#   # hitless_words   = hitless.txt


#   # detect and index sentence and paragraph boundaries
#   # required for the SENTENCE and PARAGRAPH operators to work
#   # optional, allowed values are 0 and 1, default is 0
#   #
#   # index_sp      = 1


#   # index zones, delimited by HTML/XML tags
#   # a comma separated list of tags and wildcards
#   # required for the ZONE operator to work
#   # optional, default is empty string (do not index zones)
#   #
#   # index_zones   = title, h*, th


#   # index per-document and average per-index field lengths, in tokens
#   # required for the BM25A(), BM25F() in expression ranker
#   # optional, default is 0 (do not index field lenghts)
#   #
#   # index_field_lengths = 1


#   # regular expressions (regexps) to filter the fields and queries with
#   # gets applied to data source fields when indexing
#   # gets applied to search queries when searching
#   # multi-value, optional, default is empty list of regexps
#   #
#   # regexp_filter   = \b(\d+)\" => \1inch
#   # regexp_filter   = (blue|red) => color


#   # list of the words considered frequent with respect to bigram indexing
#   # optional, default is empty
#   #
#   # bigram_freq_words = the, a, i, you, my


#   # bigram indexing mode
#   # known values are none, all, first_freq, both_freq
#   # option, default is none (do not index bigrams)
#   #
#   # bigram_index    = both_freq


#   # snippet document file name prefix
#   # preprended to file names when generating snippets using load_files option
#   # WARNING, this is a prefix (not a path), trailing slash matters!
#   # optional, default is empty
#   #
#   # snippets_file_prefix  = /mnt/mydocs/server1


#   # whether to apply stopwords before or after stemming
#   # optional, default is 0 (apply stopwords after stemming)
#   #
#   # stopwords_unstemmed = 0


#   # path to a global (cluster-wide) keyword IDFs file
#   # optional, default is empty (use local IDFs)
#   #
#   # global_idf    = /usr/local/sphinx/var/global.idf
# }


# # inherited index example
# #
# # all the parameters are copied from the parent index,
# # and may then be overridden in this index definition
# index test1stemmed : test1
# {
#   path      = /var/lib/sphinxsearch/data/test1stemmed
#   morphology    = stem_en
# }


# # distributed index example
# #
# # this is a virtual index which can NOT be directly indexed,
# # and only contains references to other local and/or remote indexes
# index dist1
# {
#   # 'distributed' index type MUST be specified
#   type      = distributed

#   # local index to be searched
#   # there can be many local indexes configured
#   local     = test1
#   local     = test1stemmed

#   # remote agent
#   # multiple remote agents may be specified
#   # syntax for TCP connections is 'hostname:port:index1,[index2[,...]]'
#   # syntax for local UNIX connections is '/path/to/socket:index1,[index2[,...]]'
#   agent     = localhost:9313:remote1
#   agent     = localhost:9314:remote2,remote3
#   # agent     = /var/run/searchd.sock:remote4

#   # remote agent mirrors groups, aka mirrors, aka HA agents
#   # defines 2 or more interchangeable mirrors for a given index part
#   #
#   # agent     = server3:9312 | server4:9312 :indexchunk2
#   # agent     = server3:9312:chunk2server3 | server4:9312:chunk2server4
#   # agent     = server3:chunk2server3 | server4:chunk2server4
#   # agent     = server21|server22|server23:chunk2


#   # blackhole remote agent, for debugging/testing
#   # network errors and search results will be ignored
#   #
#   # agent_blackhole   = testbox:9312:testindex1,testindex2


#   # persistenly connected remote agent
#   # reduces connect() pressure, requires that workers IS threads
#   #
#   # agent_persistent    = testbox:9312:testindex1,testindex2


#   # remote agent connection timeout, milliseconds
#   # optional, default is 1000 ms, ie. 1 sec
#   agent_connect_timeout = 1000

#   # remote agent query timeout, milliseconds
#   # optional, default is 3000 ms, ie. 3 sec
#   agent_query_timeout   = 3000

#   # HA mirror agent strategy
#   # optional, defaults to ??? (random mirror)
#   # know values are nodeads, noerrors, roundrobin, nodeadstm, noerrorstm
#   #
#   # ha_strategy       = nodeads
# }


# # realtime index example
# #
# # you can run INSERT, REPLACE, and DELETE on this index on the fly
# # using MySQL protocol (see 'listen' directive below)
# index rt
# {
#   # 'rt' index type must be specified to use RT index
#   type      = rt

#   # index files path and file name, without extension
#   # mandatory, path must be writable, extensions will be auto-appended
#   path      = /var/lib/sphinxsearch/data/rt

#   # RAM chunk size limit
#   # RT index will keep at most this much data in RAM, then flush to disk
#   # optional, default is 32M
#   #
#   # rt_mem_limit    = 512M

#   # full-text field declaration
#   # multi-value, mandatory
#   rt_field    = title
#   rt_field    = content

#   # unsigned integer attribute declaration
#   # multi-value (an arbitrary number of attributes is allowed), optional
#   # declares an unsigned 32-bit attribute
#   rt_attr_uint    = gid

#   # RT indexes currently support the following attribute types:
#   # uint, bigint, float, timestamp, string, mva, mva64, json
#   #
#   # rt_attr_bigint    = guid
#   # rt_attr_float   = gpa
#   # rt_attr_timestamp = ts_added
#   # rt_attr_string    = author
#   # rt_attr_multi   = tags
#   # rt_attr_multi_64  = tags64
#   # rt_attr_json    = extra_data
# }

# #############################################################################
# ## indexer settings
# #############################################################################

# indexer
# {
#   # memory limit, in bytes, kiloytes (16384K) or megabytes (256M)
#   # optional, default is 32M, max is 2047M, recommended is 256M to 1024M
#   mem_limit   = 32M

#   # maximum IO calls per second (for I/O throttling)
#   # optional, default is 0 (unlimited)
#   #
#   # max_iops    = 40


#   # maximum IO call size, bytes (for I/O throttling)
#   # optional, default is 0 (unlimited)
#   #
#   # max_iosize    = 1048576


#   # maximum xmlpipe2 field length, bytes
#   # optional, default is 2M
#   #
#   # max_xmlpipe2_field  = 4M


#   # write buffer size, bytes
#   # several (currently up to 4) buffers will be allocated
#   # write buffers are allocated in addition to mem_limit
#   # optional, default is 1M
#   #
#   # write_buffer    = 1M


#   # maximum file field adaptive buffer size
#   # optional, default is 8M, minimum is 1M
#   #
#   # max_file_field_buffer = 32M


#   # how to handle IO errors in file fields
#   # known values are 'ignore_field', 'skip_document', and 'fail_index'
#   # optional, default is 'ignore_field'
#   #
#   # on_file_field_error = skip_document


#   # how to handle syntax errors in JSON attributes
#   # known values are 'ignore_attr' and 'fail_index'
#   # optional, default is 'ignore_attr'
#   #
#   # on_json_attr_error = fail_index


#   # whether to auto-convert numeric values from strings in JSON attributes
#   # with auto-conversion, string value with actually numeric data
#   # (as in {"key":"12345"}) gets stored as a number, rather than string
#   # optional, allowed values are 0 and 1, default is 0 (do not convert)
#   #
#   # json_autoconv_numbers = 1


#   # whether and how to auto-convert key names in JSON attributes
#   # known value is 'lowercase'
#   # optional, default is unspecified (do nothing)
#   #
#   # json_autoconv_keynames = lowercase


#   # lemmatizer dictionaries base path
#   # optional, defaut is /usr/local/share (see ./configure --datadir)
#   #
#   # lemmatizer_base = /usr/local/share/sphinx/dicts


#   # lemmatizer cache size
#   # improves the indexing time when the lemmatization is enabled
#   # optional, default is 256K
#   #
#   # lemmatizer_cache = 512M
# }

# #############################################################################
# ## searchd settings
# #############################################################################

# searchd
# {
#   # [hostname:]port[:protocol], or /unix/socket/path to listen on
#   # known protocols are 'sphinx' (SphinxAPI) and 'mysql41' (SphinxQL)
#   #
#   # multi-value, multiple listen points are allowed
#   # optional, defaults are 9312:sphinx and 9306:mysql41, as below
#   #
#   # listen      = 127.0.0.1
#   # listen      = 192.168.0.1:9312
#   # listen      = 9312
#   # listen      = /var/run/searchd.sock
#   listen      = 9312
#   listen      = 9306:mysql41

#   # log file, searchd run info is logged here
#   # optional, default is 'searchd.log'
#   log     = /var/log/sphinxsearch/searchd.log

#   # query log file, all search queries are logged here
#   # optional, default is empty (do not log queries)
#   query_log   = /var/log/sphinxsearch/query.log

#   # client read timeout, seconds
#   # optional, default is 5
#   read_timeout    = 5

#   # request timeout, seconds
#   # optional, default is 5 minutes
#   client_timeout    = 300

#   # maximum amount of children to fork (concurrent searches to run)
#   # optional, default is 0 (unlimited)
#   max_children    = 30

#   # maximum amount of persistent connections from this master to each agent host
#   # optional, but necessary if you use agent_persistent. It is reasonable to set the value
#   # as max_children, or less on the agent's hosts.
#   persistent_connections_limit  = 30

#   # PID file, searchd process ID file name
#   # mandatory
#   pid_file    = /var/run/sphinxsearch/searchd.pid

#   # max amount of matches the daemon ever keeps in RAM, per-index
#   # WARNING, THERE'S ALSO PER-QUERY LIMIT, SEE SetLimits() API CALL
#   # default is 1000 (just like Google)
#   max_matches   = 1000

#   # seamless rotate, prevents rotate stalls if precaching huge datasets
#   # optional, default is 1
#   seamless_rotate   = 1

#   # whether to forcibly preopen all indexes on startup
#   # optional, default is 1 (preopen everything)
#   preopen_indexes   = 1

#   # whether to unlink .old index copies on succesful rotation.
#   # optional, default is 1 (do unlink)
#   unlink_old    = 1

#   # attribute updates periodic flush timeout, seconds
#   # updates will be automatically dumped to disk this frequently
#   # optional, default is 0 (disable periodic flush)
#   #
#   # attr_flush_period = 900


#   # instance-wide ondisk_dict defaults (per-index value take precedence)
#   # optional, default is 0 (precache all dictionaries in RAM)
#   #
#   # ondisk_dict_default = 1


#   # MVA updates pool size
#   # shared between all instances of searchd, disables attr flushes!
#   # optional, default size is 1M
#   mva_updates_pool  = 1M

#   # max allowed network packet size
#   # limits both query packets from clients, and responses from agents
#   # optional, default size is 8M
#   max_packet_size   = 8M

#   # crash log path
#   # searchd will (try to) log crashed query to 'crash_log_path.PID' file
#   # optional, default is empty (do not create crash logs)
#   #
#   # crash_log_path    = /var/log/sphinxsearch/crash


#   # max allowed per-query filter count
#   # optional, default is 256
#   max_filters   = 256

#   # max allowed per-filter values count
#   # optional, default is 4096
#   max_filter_values = 4096


#   # socket listen queue length
#   # optional, default is 5
#   #
#   # listen_backlog    = 5


#   # per-keyword read buffer size
#   # optional, default is 256K
#   #
#   # read_buffer   = 256K


#   # unhinted read size (currently used when reading hits)
#   # optional, default is 32K
#   #
#   # read_unhinted   = 32K


#   # max allowed per-batch query count (aka multi-query count)
#   # optional, default is 32
#   max_batch_queries = 32


#   # max common subtree document cache size, per-query
#   # optional, default is 0 (disable subtree optimization)
#   #
#   # subtree_docs_cache  = 4M


#   # max common subtree hit cache size, per-query
#   # optional, default is 0 (disable subtree optimization)
#   #
#   # subtree_hits_cache  = 8M


#   # multi-processing mode (MPM)
#   # known values are none, fork, prefork, and threads
#   # threads is required for RT backend to work
#   # optional, default is fork
#   workers     = threads # for RT to work


#   # max threads to create for searching local parts of a distributed index
#   # optional, default is 0, which means disable multi-threaded searching
#   # should work with all MPMs (ie. does NOT require workers=threads)
#   #
#   # dist_threads    = 4


#   # binlog files path; use empty string to disable binlog
#   # optional, default is build-time configured data directory
#   #
#   # binlog_path   = # disable logging
#   # binlog_path   = /var/lib/sphinxsearch/data # binlog.001 etc will be created there


#   # binlog flush/sync mode
#   # 0 means flush and sync every second
#   # 1 means flush and sync every transaction
#   # 2 means flush every transaction, sync every second
#   # optional, default is 2
#   #
#   # binlog_flush    = 2


#   # binlog per-file size limit
#   # optional, default is 128M, 0 means no limit
#   #
#   # binlog_max_log_size = 256M


#   # per-thread stack size, only affects workers=threads mode
#   # optional, default is 64K
#   #
#   # thread_stack      = 128K


#   # per-keyword expansion limit (for dict=keywords prefix searches)
#   # optional, default is 0 (no limit)
#   #
#   # expansion_limit   = 1000


#   # RT RAM chunks flush period
#   # optional, default is 0 (no periodic flush)
#   #
#   # rt_flush_period   = 900


#   # query log file format
#   # optional, known values are plain and sphinxql, default is plain
#   #
#   # query_log_format    = sphinxql


#   # version string returned to MySQL network protocol clients
#   # optional, default is empty (use Sphinx version)
#   #
#   # mysql_version_string  = 5.0.37


#   # trusted plugin directory
#   # optional, default is empty (disable UDFs)
#   #
#   # plugin_dir      = /usr/local/sphinx/lib


#   # default server-wide collation
#   # optional, default is libc_ci
#   #
#   # collation_server    = utf8_general_ci


#   # server-wide locale for libc based collations
#   # optional, default is C
#   #
#   # collation_libc_locale = ru_RU.UTF-8


#   # threaded server watchdog (only used in workers=threads mode)
#   # optional, values are 0 and 1, default is 1 (watchdog on)
#   #
#   # watchdog        = 1


#   # SphinxQL compatibility mode (legacy columns and their names)
#   # optional, default is 1 (old-style)
#   #
#   # compat_sphinxql_magics  = 1


#   # costs for max_predicted_time model, in (imaginary) nanoseconds
#   # optional, default is "doc=64, hit=48, skip=2048, match=64"
#   #
#   # predicted_time_costs  = doc=64, hit=48, skip=2048, match=64


#   # current SphinxQL state (uservars etc) serialization path
#   # optional, default is none (do not serialize SphinxQL state)
#   #
#   # sphinxql_state      = sphinxvars.sql


#   # maximum RT merge thread IO calls per second, and per-call IO size
#   # useful for throttling (the background) OPTIMIZE INDEX impact
#   # optional, default is 0 (unlimited)
#   #
#   # rt_merge_iops     = 40
#   # rt_merge_maxiosize    = 1M


#   # interval between agent mirror pings, in milliseconds
#   # 0 means disable pings
#   # optional, default is 1000
#   #
#   # ha_ping_interval    = 0


#   # agent mirror statistics window size, in seconds
#   # stats older than the window size (karma) are retired
#   # that is, they will not affect master choice of agents in any way
#   # optional, default is 60 seconds
#   #
#   # ha_period_karma     = 60


#   # delay between preforked children restarts on rotation, in milliseconds
#   # optional, default is 0 (no delay)
#   #
#   # prefork_rotation_throttle = 100


#   # a prefix to prepend to the local file names when creating snippets
#   # with load_files and/or load_files_scatter options
#   # optional, default is empty
#   #
#   # snippets_file_prefix    = /mnt/common/server1/
# }

# # --eof--
### ORIGINAL SPHINX.CONF ###
############################


### EXAMPLE ###

## Example SQL
# CREATE TABLE documents (
#   id      INTEGER PRIMARY KEY NOT NULL,
#   group_id  INTEGER NOT NULL,
#   group_id2 INTEGER NOT NULL,
#   date_added  timestamp DEFAULT current_timestamp,
#   title   VARCHAR(255) NOT NULL,
#   content   TEXT NOT NULL
# );

# INSERT INTO documents ( id, group_id, group_id2, date_added, title, content ) VALUES
#   ( 1, 1, 5, NOW(), 'test one', 'this is my test document number one. also checking search within phrases.' ),
#   ( 2, 1, 6, NOW(), 'test two', 'this is my test document number two' ),
#   ( 3, 2, 7, NOW(), 'another doc', 'this is another group' ),
#   ( 4, 2, 8, NOW(), 'doc number four', 'this is to test groups' );

# CREATE TABLE tags (
#   docid INTEGER NOT NULL,
#   tagid INTEGER NOT NULL,
#   UNIQUE(docid,tagid)
# );

# INSERT INTO tags VALUES
#   (1,1), (1,3), (1,5), (1,7),
#   (2,6), (2,4), (2,2),
#   (3,15),
#   (4,7), (4,40);

## Postgresql data
# sphinx_test=# SELECT * FROM documents;
#  id | group_id | group_id2 |         date_added         |      title      |                                  content
# ----+----------+-----------+----------------------------+-----------------+---------------------------------------------------------------------------
#   1 |        1 |         5 | 2014-02-20 12:42:36.256875 | test one        | this is my test document number one. also checking search within phrases.
#   2 |        1 |         6 | 2014-02-20 12:42:36.256875 | test two        | this is my test document number two
#   3 |        2 |         7 | 2014-02-20 12:42:36.256875 | another doc     | this is another group
#   4 |        2 |         8 | 2014-02-20 12:42:36.256875 | doc number four | this is to test groups
# (4 rows)

# sphinx_test=# SELECT * FROM tags;
#  docid | tagid
# -------+-------
#      1 |     1
#      1 |     3
#      1 |     5
#      1 |     7
#      2 |     6
#      2 |     4
#      2 |     2
#      3 |    15
#      4 |     7
#      4 |    40
# (10 rows)

## INSTALL
# sudo cat <<-EOF > /tmp/sphinx.list;
# ## Sphinx packages
# deb http://ppa.launchpad.net/builds/sphinxsearch-beta/ubuntu $PG_CODENAME main
# deb-src http://ppa.launchpad.net/builds/sphinxsearch-beta/ubuntu $PG_CODENAME main
# EOF
# sudo mv -f /tmp/sphinx.list /etc/apt/sources.list.d/sphinx.list;
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 16932B16
# sudo apt-get install sphinxsearch
