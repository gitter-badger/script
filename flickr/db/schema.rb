require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :blogs do |t|
    t.integer :id
  end

  create_table :cameras do |t|
    t.integer :id
  end

  create_table :collections do |t|
    t.integer :id
  end

  create_table :photos do |t|
    t.integer :id
  end

  create_table :commons do |t|
    t.integer :id
  end

  create_table :contacts do |t|
    t.integer :id
  end

  create_table :favorites do |t|
    t.integer :id
  end

  create_table :galleries do |t|
    t.integer :id
  end

  create_table :groups do |t|
    t.integer :id
  end

  create_table :interestingness do |t|
    t.integer :id
  end

  create_table :peoples do |t|
    t.integer :id
  end

  create_table :tags do |t|
    t.integer :id
  end

  create_table :urls do |t|
    t.integer :id
  end

  create_table :stats do |t|
    t.integer :id
  end

  create_table :places do |t|
    t.integer :id
  end

  create_table :photosets do |t|
    t.integer :id
  end
end
