require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :comments do |t|
    t.integer :id
  end

  create_table :follows do |t|
    t.integer :id
  end

  create_table :intros do |t|
    t.integer :id
  end

  create_table :jobs do |t|
    t.integer :id
  end

  create_table :likes do |t|
    t.integer :id
  end

  create_table :messages do |t|
    t.integer :id
  end

  create_table :paths do |t|
    t.integer :id
  end

  create_table :presses do |t|
    t.integer :id
  end

  create_table :reviews do |t|
    t.integer :id
  end

  create_table :searches do |t|
    t.integer :id
  end

  create_table :startups do |t|
    t.integer :id
  end

  create_table :roles do |t|
    t.integer :id
  end

  create_table :updates do |t|
    t.integer :id
  end

  create_table :reviews do |t|
    t.integer :id
  end

  create_table :tags do |t|
    t.integer :id
  end

  create_table :users do |t|
    t.integer :id
  end
end
