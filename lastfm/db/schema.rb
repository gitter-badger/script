require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :albums do |t|
    t.integer :id
  end

  create_table :geos do |t|
    t.integer :id
  end

  create_table :artists do |t|
    t.integer :id
  end

  create_table :tracks do |t|
    t.integer :id
  end

  create_table :groups do |t|
    t.integer :id
  end

  create_table :libraries do |t|
    t.integer :id
  end

  create_table :users do |t|
    t.integer :id
  end

  create_table :charts do |t|
    t.integer :id
  end

  create_table :playlists do |t|
    t.integer :id
  end

  create_table :events do |t|
    t.integer :id
  end

  create_table :tags do |t|
    t.integer :id
  end

  create_table :radios do |t|
    t.integer :id
  end

  create_table :tasteometers do |t|
    t.integer :id
  end

  create_table :venues do |t|
    t.integer :id
  end
end
