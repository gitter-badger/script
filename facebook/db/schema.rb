require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :achievements do |t|
    t.integer :id
  end

  create_table :albums do |t|
    t.integer :id
  end

  create_table :applications do |t|
    t.integer :id
  end

  create_table :checkins do |t|
    t.integer :id
  end

  create_table :comments do |t|
    t.integer :id
  end

  create_table :domains do |t|
    t.integer :id
  end

  create_table :events do |t|
    t.integer :id
  end

  create_table :friendlists do |t|
    t.integer :id
  end

  create_table :groups do |t|
    t.integer :id
  end

  create_table :links do |t|
    t.integer :id
  end

  create_table :messages do |t|
    t.integer :id
  end

  create_table :milestones do |t|
    t.integer :id
  end

  create_table :notes do |t|
    t.integer :id
  end

  create_table :offers do |t|
    t.integer :id
  end

  create_table :pages do |t|
    t.integer :id
  end

  create_table :payments do |t|
    t.integer :id
  end

  create_table :photos do |t|
    t.integer :id
  end

  create_table :posts do |t|
    t.integer :id
  end

  create_table :questions do |t|
    t.integer :id
  end

  create_table :reviews do |t|
    t.integer :id
  end

  create_table :statuses do |t|
    t.integer :id
  end

  create_table :threads do |t|
    t.integer :id
  end

  create_table :users do |t|
    t.integer :id
  end

  create_table :videos do |t|
    t.integer :id
  end
end
