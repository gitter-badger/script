require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :canvas do |t|
    t.text :title, null: false
    t.text :customer_segments
    t.text :key_partners
    t.text :customer_relationships
    t.text :key_activities
    t.text :channels
    t.text :key_resources
    t.text :value_propositions
    t.text :cost_structure
    t.text :revenue_streams

    t.datetime :created_at
    t.datetime :modified_at
  end
end
