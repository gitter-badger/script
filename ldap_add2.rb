#!/usr/bin/ruby -w
# ldap_add2.rb
# Author: Andy Bettisworth
# Description: Add an LDAP entry

Receipient = Struct.new(:forename, :surname, :street, :postal_code, :city, :state, :description)

class AddressBook
  def udn
    'uid=' + @user.uid + ',' + BASE_DC
  end

  def add(recipient)
    cn = recipient.forename + ' ' + recipient.surname
    entry = {
      'objectclass' => %w(top residentialPerson),
      'cn' => [cn],
      'sn' => [recipient.surname],
      'l' => [recipient.city],
      'street' => [recipient.street],
      'postalCode' => [recipient.postal_code],
      'st' => [recipient.state || ''],
      'description' => [recipient.description || '']
    }
    @connection.add('cn=' + cn + ',' + udn(), entry)
end

if __FILE__ == $0
  user = User.new('23', 'Jane', 'Doe')
  address_book = AddressBook.new(connection, user)
  recipient = Recipient.new(
    'Jose', 'Rodriquez',
    'Casanova Street 6', '7702',
    'Houston', 'TX',
    'Rrrrrr!'
  )
  address_book.add(recipient)
end
