require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :connects do |t|
    t.integer :id
  end

  create_table :users do |t|
    t.integer :id
  end

  create_table :tracks do |t|
    t.integer :id
  end

  create_table :playlists do |t|
    t.integer :id
  end

  create_table :groups do |t|
    t.integer :id
  end

  create_table :comments do |t|
    t.integer :id
  end

  create_table :connections do |t|
    t.integer :id
  end

  create_table :activities do |t|
    t.integer :id
  end

  create_table :apps do |t|
    t.integer :id
  end
end
