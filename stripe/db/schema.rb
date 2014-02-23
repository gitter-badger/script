require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :charges do |t|
    t.integer :id
  end

  create_table :coupons do |t|
    t.integer :id
  end

  create_table :customers do |t|
    t.integer :id
  end

  create_table :subscriptions do |t|
    t.integer :id
  end

  create_table :invoices do |t|
    t.integer :id
  end

  create_table :invoice_items do |t|
    t.integer :id
  end

  create_table :plans do |t|
    t.integer :id
  end

  create_table :tokens do |t|
    t.integer :id
  end

  create_table :events do |t|
    t.integer :id
  end
end
