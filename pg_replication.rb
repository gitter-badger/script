#!/usr/bin/ruby -w
# pg_replication.rb
# Author: Andy Bettisworth
# Description: Postgresql Replication Management

## Commands
# enable/disable
#

# 1.
# CREATE ROLE pgrepuser REPLICATION LOGIN PASSWORD 'trichoderma'

# 2.
# wal_level = hot_standby
# archive_mode = on
# max_wal_senders = 10

# 3.
# archive_command = 'cp %p ../archive/%f'

# 4.
# host replication pgrepuser 192.168.0.0/24 md5

# 5.
# sudo service postgresql stop
# copy everything in the 'data_directory'
# ~OR~
# pg_basebackup -U pgrepuser -D backup -Ft -z -P
## NOTE ensure


## > TODO handle creating slaves

# 1.
# create pg server with same version
# 2.
# shutdown pg service
# 3.
# overwrite data folder `pg_config` data_directory
# 4.
# set hot_standby = on
# 5.
