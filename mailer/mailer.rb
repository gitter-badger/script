require 'pg'
require 'active_record'
require 'yaml'
require 'logger'


ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  # create_table :messages do |t|
  #   t.text :from_address
  #   t.text :to_address
  #   t.text :cc_address
  #   t.text :bc_address
  #   t.text :subject
  #   t.text :content
  # end
end

class Message < ActiveRecord::Base
  attr_accessor :from_address, :to_address
end

msg = Message.new
msg.from_address = 'bettisworth@gmail.com'

puts msg.from_address