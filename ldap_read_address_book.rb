#!/usr/bin/ruby -w
# ldap_read_address_book.rb
# Author: Andy Bettisworth
# Description: Read all the LDAY address book entries

require 'ldap/ldif'

class AddressBook
  include Enumerable

  def each
    @connection.search(
      udn,
      LDAP_SCOPE_ONELEVEL,
      '(objectClass=residentialPerson',
      nil, false, 0, 0,
      'sn'
    ) do |recipient|
      yield recipient
    end
  end

  def each_recipient
    each do |entry|
      rec_data = entry.to_hash
      sn = rec_data['sn'][0]
      cn = rec_data['cn'][0]
      cn.sub!(Regexp.new(' ' + sn + '$'), '')
      yield Recipient.new(
        cn,
        sn,
        rec_data['street'][0],
        rec_data['postalCode'][0],
        rec_data['l'][0],
        rec_data['st'][0],
        rec_data['description'][0]
        )
    end
  end

  def to_ldif
    inject('') { |ldif, e| ldif << e.to_ldif }
  end
end


user = User.new('23', 'Jane', 'Doe')
address_book = AddressBook.new(connection, user)
address_book.each_recipient { |recipient| pp recipient }

# OR with formating

puts address_book.to_ldif