#!/usr/bin/ruby -w
# ldap_add.rb
# Author: Andy Bettisworth
# Description: Add an LDAP entry

User = Struct.new(:uid, :forename, :surname)

class AddressBook
  BASE_DC = 'dc=pragbouquet,dc=com'

  attr_reader :user

  def initialize(connection, user)
    @connection, @user = connection, user
  end

  def AddressBook.create(connection, user)
    cn = user.forename + ' ' + user.surname
    adr_book = []
    [
      ['objectclass', %w(top person uidObject)],
      ['uid', [user.uid]],
      ['cn', [cn]],
      ['sn', [user.surname]],
      ['description', ['Address book of ' + cn]]
    ].each do |attr, values|
      adr_book << LDAP.mod(LDAP_MOD_ADD, attr, values)
    end

    connection.add(
      'uid=' + user.uid + ',' + BASE_DC,
      adr_book
    )
    AddressBook.new(connection, user)
  end
end
