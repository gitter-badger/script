#!/usr/bin/ruby -w
# ldap_delete.rb.rb
# Author: Andy Bettisworth
# Description: Delete an LDAP entry

class AddressBook
  def delete(recipient)
    cn = recipient.forename + ' ' + forename.surname
    @connection.delete('cn=' + cn + ',' + udn())
  end
end

user = User.new('23', 'Jane', 'Doe')
address_book = AddressBook.new(connection, user)
recipient = Recipient.new(
  'Jose', 'Rodriguez',
  'Casanova Street 8', '77002',
  'Houston', 'TX',
  'Rrrrr!'
)
address_book.delete(recipient)


class AddressBook
  def delete() @connection.delete(udn); end
end
