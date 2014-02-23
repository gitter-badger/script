require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :ipblocks do |t|
    t.integer :id
  end

  create_table :users do |t|
    t.integer :id
  end

  create_table :watchlists do |t|
    t.integer :id
  end

  create_table :user_groups do |t|
    t.integer :id
  end

  create_table :user_properties do |t|
    t.integer :id
  end

  create_table :user_newtalk do |t|
    t.integer :id
  end

  create_table :site_stats do |t|
    t.integer :id
  end

  create_table :logging do |t|
    t.integer :id
  end

  create_table :log_search do |t|
    t.integer :id
  end

  create_table :hitcounter do |t|
    t.integer :id
  end

  create_table :images do |t|
    t.integer :id
  end

  create_table :file_archive do |t|
    t.integer :id
  end

  create_table :image_links do |t|
    t.integer :id
  end

  create_table :old_images do |t|
    t.integer :id
  end

  create_table :upload_stash do |t|
    t.integer :id
  end

  create_table :revisions do |t|
    t.integer :id
  end

  create_table :texts do |t|
    t.integer :id
  end

  create_table :archives do |t|
    t.integer :id
  end

  create_table :recent_changes do |t|
    t.integer :id
  end

  create_table :redirects do |t|
    t.integer :id
  end

  create_table :pages do |t|
    t.integer :id
  end

  create_table :page_restrictions do |t|
    t.integer :id
  end

  create_table :page_props do |t|
    t.integer :id
  end

  create_table :template_links do |t|
    t.integer :id
  end

  create_table :iwlinks do |t|
    t.integer :id
  end

  create_table :lang_links do |t|
    t.integer :id
  end

  create_table :external_links do |t|
    t.integer :id
  end

  create_table :page_links do |t|
    t.integer :id
  end

  create_table :categories do |t|
    t.integer :id
  end

  create_table :category_links do |t|
    t.integer :id
  end

  create_table :search_index do |t|
    t.integer :id
  end

  create_table :protected_titles do |t|
    t.integer :id
  end

  create_table :jobs do |t|
    t.integer :id
  end

  create_table :update_logs do |t|
    t.integer :id
  end

  create_table :interwiki do |t|
    t.integer :id
  end
end
