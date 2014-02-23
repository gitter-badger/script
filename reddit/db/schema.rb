require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :accounts do |t|
    t.integer :id
  end

  create_table :apps do |t|
    t.integer :id
  end

  create_table :flairs do |t|
    t.integer :id
  end

  create_table :links do |t|
    t.integer :id
  end

  create_table :comments do |t|
    t.integer :id
  end

  create_table :listings do |t|
    t.integer :id
  end

  create_table :messages do |t|
    t.integer :id
  end

  create_table :moderations do |t|
    t.integer :id
  end

  create_table :multis do |t|
    t.integer :id
  end

  create_table :searches do |t|
    t.integer :id
  end

  create_table :subreddits do |t|
    t.integer :id
  end

  create_table :users do |t|
    t.integer :id
  end

  create_table :wikis do |t|
    t.integer :id
  end
end
