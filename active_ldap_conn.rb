#!/usr/bin/ruby -w
# active_ldap_conn.rb.rb
# Author: Andy Bettisworth
# Description: Open an Active LDAP connection

require 'rubygems'
require 'activeldap'

ActiveLDAP::Base.connect(
  base: 'dc=pragbouquet,dc=com',
  bind_format: 'cn=root,dc=pragbouquet,dc=com',
  password_block: Proc.new { 'secret' },
  allow_anonymous: false
)

# ~OR~

class Group < ActiveLDAP::Base
  ldap_mapping dnattr: 'cn', prefix: 'out=Groups'
end

customers = Group.new('customers')
puts "The 'customers' group has the following attributes:"
customers.attributes.each { |attribute| puts " #{attribute}" }
puts "\nIts group id is #{customers.gidNumber}."

puts "\nWe have the following groups:"
Group.find_all('*').each { |group| puts " #{group}" }


# READ using query methods like with ActiveRecord

Group.find(attributes: 'gidNumber', value: '23', objects: true)

Group.search(filter: '(cn=cus*)')


class Customer < ActiveRecord::Base
  ldap_mapping dnattr: 'uid', prefix: 'cn=customers,ou=Groups'
end

puts "Our customers are:"
Customer.find_all('*').each { |customer| puts " #{customer}" }
homer = Customer.new('homer@example.com')
puts "\nCommon name attribute:"
p homer.cn
p homer.cn(true)


def get_unused_accounts(used_accounts)
  unused_accounts = []
  Customer.find_all('*').each do |email|
    unused_accounts << email if !used_accounts.include?(email)
  end
  unused_accounts
end
puts  get_unused_accounts(['homer@example.com'])


def delete_unused_accounst(used_accounts)
  Customer.find_all('*').each do |cn|
    Customer.new(cn).delete if !used_accounts.include?(cn)
  end
end


def mark_unused_accounts(used_accounts)
  Customer.find_all('*').each do |customer|
    if !used_accounts.include?(customer)
      c = Customer.new(customer)
      c.description = 'unused'
      c.write
    end
  end
end


class Customer < ActiveLDAP::Base
  ldap_mapping dnattr: 'uid', prefix: 'cn=customers,ou=Groups'

  belongs_to :groups,
             class_name: 'Groups',
             foreign_key: 'gidNumber',
             local_key: 'gidNumber'
end
h = Customer.new('homer@example.com')
h.groups.each { |g| puts g.cn }

class Group < ActiveLDAP::Base
  ldap_mapping dnattr: 'cn', prefix: 'ou=Groups'

  has_many :members,
           class_name: 'Employee',
           local_key: 'gidNumber',
           foreign_key: 'gidNumber'
end

class Employee < ActiveLDAP::Base
  ldap_mapping dnattr: 'uid', prefix: 'cn=employees,ou=Groups'
end

employees = Group.new('employees')
employees.members.each { |emp| puts emp.cn }

