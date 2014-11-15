#!/usr/bin/ruby -w
# ldap_update.rb.rb
# Author: Andy Bettisworth
# Description: Update an LDAP entry

class AddressBook
  def update(recipient)
    cn = recipient.forename + ' ' + recipient.surname
    entry = {
      'l' => [recipient.city],
      'street' => [recipient.street],
      'postal_code' => [recipient.postal_code],
      'st' => [recipient.state],
      'description' => [recipient.description]
    }
    @connection.modify('cn=' + cn + ',' + udn(), entry)
  end
end


if __FILE__ == $0
  # UPDATE object identified by 'distinguished name' (dn)
  # `LDAP::Conn.modify(dn, attributes)`
  user = User.new('23', 'Jane', 'Doe')
  address_book = AddressBook.new(connection, user)
  recipient = Recipient.new(
    'Jose', 'Rodriguez',
    'Casanova Street 8', '77002',
    'Houston', 'TX',
    'Rrrrrr!'
  )
  address_book.update(recipient)
end
