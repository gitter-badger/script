require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.integer :id
  end

  create_table :relationships do |t|
    t.integer :id
  end

  create_table :medias do |t|
    t.integer :id
  end

  create_table :comments do |t|
    t.integer :id
  end

  create_table :likes do |t|
    t.integer :id
  end

  create_table :tags do |t|
    t.integer :id
  end

  create_table :locations do |t|
    t.integer :id
  end

  create_table :geographies do |t|
    t.integer :id
  end
end
