require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :searches do |t|
    t.integer :id
  end

  create_table :locales do |t|
    t.integer :id
  end

  create_table :regions do |t|
    t.integer :id
  end

  create_table :businesses do |t|
    t.integer :id
  end

  create_table :categories do |t|
    t.integer :id
  end

  create_table :locations do |t|
    t.integer :id
  end

  create_table :deals do |t|
    t.integer :id
  end

  create_table :gift_certificates do |t|
    t.integer :id
  end

  create_table :reviews do |t|
    t.integer :id
  end

  create_table :ratings do |t|
    t.integer :id
  end
end
