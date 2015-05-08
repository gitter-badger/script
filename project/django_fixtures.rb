#!/usr/bin/env ruby
# django_fixtures.rb
# Author: Andy Bettisworth
# Created At: 2015 0508 081256
# Modified At: 2015 0508 081256
# Description: Generator of Django Fixtures

module Django
  class Fixture
    def initialize
      puts 'BAZINGA!'
    end
  end
end

if __FILE__ == $0
  if ARGV[0]
    Django::Fixture.new
  else
    puts <<-HELP
Usage: django_fixtures MODEL FILE"

Example MODEL:
  auth.GroupPermissions

Example FILE:
  <Array: fields>, <Array: records <Array: data>>
  [group_id, permission_id], [[1001,3], [1001,4], [1002,3]]

Result:
  - model: auth.GroupPermissions
    fields:
      group_id: 1001
      permission_id: 3
  - model: auth.GroupPermissions
    fields:
      group_id: 1001
      permission_id: 4
  - model: auth.GroupPermissions
    fields:
      group_id: 1002
      permission_id: 3
    HELP
    exit 1
  end
end
