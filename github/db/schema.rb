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

  create_table :organizations do |t|
    t.integer :id
  end

  create_table :repositories do |t|
    t.integer :id
  end

  create_table :contributors do |t|
    t.integer :id
  end

  create_table :languages do |t|
    t.integer :id
  end

  create_table :tags do |t|
    t.integer :id
  end

  create_table :branches do |t|
    t.integer :id
  end

  create_table :releases do |t|
    t.integer :id
  end

  create_table :merges do |t|
    t.integer :id
  end

  create_table :collaborators do |t|
    t.integer :id
  end

  create_table :comments do |t|
    t.integer :id
  end

  create_table :commits do |t|
    t.integer :id
  end

  create_table :contents do |t|
    t.integer :id
  end

  create_table :deploy_keys do |t|
    t.integer :id
  end

  create_table :deployments do |t|
    t.integer :id
  end

  create_table :downloads do |t|
    t.integer :id
  end

  create_table :forks do |t|
    t.integer :id
  end

  create_table :hooks do |t|
    t.integer :id
  end

  create_table :pages do |t|
    t.integer :id
  end

  create_table :releases do |t|
    t.integer :id
  end

  create_table :statistics do |t|
    t.integer :id
  end

  create_table :statuses do |t|
    t.integer :id
  end
end
