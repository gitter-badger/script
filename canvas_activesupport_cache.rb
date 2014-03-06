#!/usr/bin/ruby -w
# canvas_activesupport_cache.rb
# Author: Andy Bettisworth
# Description: ActiveSupport::Cache


## Cache Types
# CLASS ActiveSupport::Cache::FileStore
  # A cache store implementation which stores everything on the filesystem.
  # [FileStore implements the Strategy::LocalCache] strategy which implements an in-memory cache inside of a block.
# CLASS ActiveSupport::Cache::MemCacheStore
  # A cache store implementation which stores data in Memcached: memcached.org/
  # This is currently the most popular cache store for production websites.
  # Clustering and load balancing.
  # One can specify multiple memcached servers, and MemCacheStore will load balance
  # between all available servers. If a server goes down, then MemCacheStore will
  # ignore it until it comes back up.
  # [MemCacheStore implements the Strategy::LocalCache] strategy which implements an in-memory cache inside of a block.
# CLASS ActiveSupport::Cache::MemoryStore
# CLASS ActiveSupport::Cache::NullStore
# CLASS ActiveSupport::Cache::Store

## Ruby Doc
# = AAccttiivveeSSuuppppoorrtt::::CCaacchhee
# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------
# See ActiveSupport::Cache::Store for documentation.
# ------------------------------------------------------------------------------
# = CCoonnssttaannttss::

# UNIVERSAL_OPTIONS:
#   These options mean something to all cache implementations. Individual cache
#   implementations may support additional options.

# = IInnssttaannccee  mmeetthhooddss::

#   expand_cache_key
#   lookup_store
#   retrieve_cache_key
#   retrieve_store_class

