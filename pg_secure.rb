#!/usr/bin/ruby -w
# pg_secure.rb
# Author: Andy Bettisworth
# Description: Read how secure a postgresql server is

# > config file permissions
# > recent logins; including failures w/ ip
# > recent role creations; including failures w/ ip
# > recent database creations; including failures w/ ip
# > existing roles (whitelist)
# > existing databases (whitelist)
# > longest connections
# > most expensive connections
# > pg_hba.conf
