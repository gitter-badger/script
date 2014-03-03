require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :answers do |t|
    t.integer :id
  end

  create_table :badges do |t|
    t.integer :id
  end

  create_table :comments do |t|
    t.integer :id
  end

  create_table :events do |t|
    t.integer :id
  end

  create_table :posts do |t|
    t.integer :id
  end

  create_table :privileges do |t|
    t.integer :id
  end

  create_table :questions do |t|
    t.integer :id
  end

  create_table :revisions do |t|
    t.integer :id
  end

  create_table :tags do |t|
    t.integer :id
  end

  create_table :users do |t|
    t.integer :id
  end
end
