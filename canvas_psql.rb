#!/usr/bin/env ruby -w
# package_psql.sh
# Description: Command-line interface to PostgreSQL

## > Backup target database
  # pg_dump
## > LOCK user creation & priviledges
  # pg_ident.conf
## > LOCK read+write priviledges
  # pg_hba.conf
## > VERSIONING database schemas
## > CHECK performance
## > READ WAL
## > CONNECT database to monitoring tools
## > simple replication 1 to 1 WARM
## > complex replication 1 to many HOT

####################################
### Postgresql Command-Line Help ###
# psql is the PostgreSQL interactive terminal.

# Usage:
#   psql [OPTION]... [DBNAME [USERNAME]]

# General options:
#   -c, --command=COMMAND    run only single command (SQL or internal) and exit
#   -d, --dbname=DBNAME      database name to connect to (default: "wurde")
#   -f, --file=FILENAME      execute commands from file, then exit
#   -l, --list               list available databases, then exit
#   -v, --set=, --variable=NAME=VALUE
#                            set psql variable NAME to VALUE
#   -V, --version            output version information, then exit
#   -X, --no-psqlrc          do not read startup file (~/.psqlrc)
#   -1 ("one"), --single-transaction
#                            execute as a single transaction (if non-interactive)
#   -?, --help               show this help, then exit

# Input and output options:
#   -a, --echo-all           echo all input from script
#   -e, --echo-queries       echo commands sent to server
#   -E, --echo-hidden        display queries that internal commands generate
#   -L, --log-file=FILENAME  send session log to file
#   -n, --no-readline        disable enhanced command line editing (readline)
#   -o, --output=FILENAME    send query results to file (or |pipe)
#   -q, --quiet              run quietly (no messages, only query output)
#   -s, --single-step        single-step mode (confirm each query)
#   -S, --single-line        single-line mode (end of line terminates SQL command)

# Output format options:
#   -A, --no-align           unaligned table output mode
#   -F, --field-separator=STRING
#                            set field separator (default: "|")
#   -H, --html               HTML table output mode
#   -P, --pset=VAR[=ARG]     set printing option VAR to ARG (see \pset command)
#   -R, --record-separator=STRING
#                            set record separator (default: newline)
#   -t, --tuples-only        print rows only
#   -T, --table-attr=TEXT    set HTML table tag attributes (e.g., width, border)
#   -x, --expanded           turn on expanded table output
#   -z, --field-separator-zero
#                            set field separator to zero byte
#   -0, --record-separator-zero
#                            set record separator to zero byte

# Connection options:
#   -h, --host=HOSTNAME      database server host or socket directory (default: "/var/run/postgresql")
#   -p, --port=PORT          database server port (default: "5432")
#   -U, --username=USERNAME  database user name (default: "wurde")
#   -w, --no-password        never prompt for password
#   -W, --password           force password prompt (should happen automatically)

# For more information, type "\?" (for internal commands) or "\help" (for SQL
# commands) from within psql, or consult the psql section in the PostgreSQL
# documentation.

# Report bugs to <pgsql-bugs@postgresql.org>.


#########################
### INTERNAL COMMANDS ###

# General
#   \copyright             show PostgreSQL usage and distribution terms
#   \g [FILE] or ;         execute query (and send results to file or |pipe)
#   \gset [PREFIX]         execute query and store results in psql variables
#   \h [NAME]              help on syntax of SQL commands, * for all commands
#   \q                     quit psql
#   \watch [SEC]           execute query every SEC seconds

# Query Buffer
#   \e [FILE] [LINE]       edit the query buffer (or file) with external editor
#   \ef [FUNCNAME [LINE]]  edit function definition with external editor
#   \p                     show the contents of the query buffer
#   \r                     reset (clear) the query buffer
#   \s [FILE]              display history or save it to file
#   \w FILE                write query buffer to file

# Input/Output
#   \copy ...              perform SQL COPY with data stream to the client host
#   \echo [STRING]         write string to standard output
#   \i FILE                execute commands from file
#   \ir FILE               as \i, but relative to location of current script
#   \o [FILE]              send all query results to file or |pipe
#   \qecho [STRING]        write string to query output stream (see \o)

# Informational
#   (options: S = show system objects, + = additional detail)
#   \d[S+]                 list tables, views, and sequences
#   \d[S+]  NAME           describe table, view, sequence, or index
#   \da[S]  [PATTERN]      list aggregates
#   \db[+]  [PATTERN]      list tablespaces
#   \dc[S+] [PATTERN]      list conversions
#   \dC[+]  [PATTERN]      list casts
# \dd[S]  [PATTERN]      show object descriptions not displayed elsewhere
# \ddp    [PATTERN]      list default privileges
# \dD[S+] [PATTERN]      list domains
# \det[+] [PATTERN]      list foreign tables
# \des[+] [PATTERN]      list foreign servers
# \deu[+] [PATTERN]      list user mappings
# \dew[+] [PATTERN]      list foreign-data wrappers
# \df[antw][S+] [PATRN]  list [only agg/normal/trigger/window] functions
# \dF[+]  [PATTERN]      list text search configurations
# \dFd[+] [PATTERN]      list text search dictionaries
# \dFp[+] [PATTERN]      list text search parsers
# \dFt[+] [PATTERN]      list text search templates
# \dg[+]  [PATTERN]      list roles
# \di[S+] [PATTERN]      list indexes
# \dl                    list large objects, same as \lo_list
# \dL[S+] [PATTERN]      list procedural languages
# \dm[S+] [PATTERN]      list materialized views
# \dn[S+] [PATTERN]      list schemas
# \do[S]  [PATTERN]      list operators
# \dO[S+] [PATTERN]      list collations
# \dp     [PATTERN]      list table, view, and sequence access privileges
# \drds [PATRN1 [PATRN2]] list per-database role settings
# \ds[S+] [PATTERN]      list sequences
# \dt[S+] [PATTERN]      list tables

#   \dT[S+] [PATTERN]      list data types
#   \du[+]  [PATTERN]      list roles
#   \dv[S+] [PATTERN]      list views
#   \dE[S+] [PATTERN]      list foreign tables
#   \dx[+]  [PATTERN]      list extensions
#   \dy     [PATTERN]      list event triggers
#   \l[+]   [PATTERN]      list databases
#   \sf[+] FUNCNAME        show a function's definition
#   \z      [PATTERN]      same as \dp

# Formatting
#   \a                     toggle between unaligned and aligned output mode
#   \C [STRING]            set table title, or unset if none
#   \f [STRING]            show or set field separator for unaligned query output
#   \H                     toggle HTML output mode (currently off)
#   \pset NAME [VALUE]     set table output option
#                          (NAME := {format|border|expanded|fieldsep|fieldsep_zero|footer|null|
#                          numericlocale|recordsep|recordsep_zero|tuples_only|title|tableattr|pager})
#   \t [on|off]            show only rows (currently off)
#   \T [STRING]            set HTML <table> tag attributes, or unset if none
#   \x [on|off|auto]       toggle expanded output (currently off)

# Connection
#   \c[onnect] [DBNAME|- USER|- HOST|- PORT|-]
#                          connect to new database (currently "wurde")
#   \encoding [ENCODING]   show or set client encoding
#   \password [USERNAME]   securely change the password for a user
#   \conninfo              display information about current connection

# Operating System
#   \cd [DIR]              change the current working directory
#   \setenv NAME [VALUE]   set or unset environment variable
#   \timing [on|off]       toggle timing of commands (currently off)
#   \! [COMMAND]           execute command in shell or start interactive shell

# Variables
#   \prompt [TEXT] NAME    prompt user to set internal variable
#   \set [NAME [VALUE]]    set internal variable, or list all if no parameters
#   \unset NAME            unset (delete) internal variable

# Large Objects
#   \lo_export LOBOID FILE
#   \lo_import FILE [COMMENT]
#   \lo_list
#   \lo_unlink LOBOID      large object operations

### INTERNAL COMMANDS ###
#########################
