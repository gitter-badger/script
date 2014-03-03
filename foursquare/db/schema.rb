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

  create_table :venues do |t|
    t.integer :id
  end

  create_table :venue_groups do |t|
    t.integer :id
  end

  create_table :checkins do |t|
    t.integer :id
  end

  create_table :tips do |t|
    t.integer :id
  end

  create_table :lists do |t|
    t.integer :id
  end

  create_table :updates do |t|
    t.integer :id
  end

  create_table :photos do |t|
    t.integer :id
  end

  create_table :settings do |t|
    t.integer :id
  end

  create_table :specials do |t|
    t.integer :id
  end

  create_table :campaigns do |t|
    t.integer :id
  end

  create_table :events do |t|
    t.integer :id
  end

  create_table :pages do |t|
    t.integer :id
  end

  create_table :page_updates do |t|
    t.integer :id
  end

  create_table :multis do |t|
    t.integer :id
  end
end
