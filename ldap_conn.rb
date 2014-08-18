#!/usr/bin/ruby -w
# ldap_conn.rb
# Author: Andy Bettisworth
# Description: Open a LDAP connection

require 'pp'
require 'ldap'

include LDAP

begin
  connection = Conn.new
  connection.set_option(LDAP_OPT_PROTOCOL_VERSION, 3)
  connection.bind do
    base_dn = 'uid=4711,dc=pragbouquet,dc=com'
    scope = LDAP_SCOPE_ONELEVEL
    filter = '(objectClass=*)'
    connection.search(base_dn, scope, filter do |entry|
      pp entry.to_hash
    end
  end
rescue Exception: ex
  puts ex
end
