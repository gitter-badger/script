require 'active_record'
require 'pg'
require 'yaml'
require 'logger'

ActiveRecord::Base.logger = Logger.new('log/database.log')
ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

ActiveRecord::Schema.define do
  create_table :basic_profile do |t|
    t.integer :profile_id
    t.text :first_name
    t.text :last_name
    t.text :maiden_name
    t.text :formatted_name
    t.text :phonetic_first_name
    t.text :phonetic_last_name
    t.text :formatted_phonetic_name
    t.text :headline
    t.text :location_name
    t.text :location_country_code
    t.text :industry
    t.integer :distance
    t.text :current_share
    t.integer :num_connections
    t.integer :num_connections_capped
    t.text :summary
    t.text :specialties
    t.text :positions
    t.text :picture_url
    t.text :public_profile_url
  end

  create_table :email_address do |t|
    t.text :email_address
  end

  create_table :full_profile do |t|
    t.timestamp :last_modified_timestamp
    t.text :proposal_comments
    t.text :associations
    t.text :interests
    t.text :publications
    t.text :patents
    t.text :languages
    t.text :skills
    t.text :certifications
    t.text :educations
    t.text :courses
    t.text :volunteer
    t.integer :three_current_positions
    t.integer :three_past_positions
    t.integer :num_recommenders
    t.integer :recommendations_received
    t.integer :mfeed_rss_url
    t.integer :following
    t.integer :job_bookmarks
    t.integer :suggestions
    t.integer :date_of_birth
    t.integer :member_url_resources
    t.integer :related_profile_views
    t.integer :honors_award
  end

  create_table :contact_info do |t|
    t.integer :phone_numbers
    t.text :bound_account_types
    t.text :im_accounts
    t.text :main_address
    t.text :twitter_accounts
    t.text :primary_twitter_account
  end

  create_table :network do |t|
    t.integer :connections
  end

  create_table :groups do |t|
    t.integer :group_memberships
  end

  create_table :nus do |t|
    t.integer :network
  end

  create_table :positions do |t|
    t.integer :id
    t.integer :title
    t.integer :summary
    t.integer :start_date
    t.integer :end_date
    t.integer :is_current
    t.integer :company
  end

  create_table :company do |t|
    t.integer :id
    t.integer :name
    t.integer :type
    t.integer :size
    t.integer :industry
    t.integer :ticker
  end

  create_table :publications do |t|
    t.integer :id
    t.integer :title
    t.integer :publisher_name
    t.integer :author_id
    t.integer :author_name
    t.integer :authors_person
    t.integer :date
    t.integer :url
    t.integer :summary
  end

  create_table :patents do |t|
    t.integer :id
    t.integer :title
    t.integer :summary
    t.integer :number
    t.integer :status_id
    t.integer :status_name
    t.integer :office_name
    t.integer :inventors_id
    t.integer :inventors_name
    t.integer :inventors_person
    t.integer :date
    t.integer :url
  end

  create_table :languages do |t|
    t.integer :id
    t.integer :language_name
    t.integer :proficiency_level
    t.integer :proficiency_name
  end

  create_table :skills do |t|
    t.integer :id
    t.integer :skill_name
  end

  create_table :certifications do |t|
    t.integer :id
    t.integer :name
    t.integer :authority_name
    t.integer :number
    t.integer :start_date
    t.integer :end_date
  end

  create_table :education do |t|
    t.integer :id
    t.integer :school_name
    t.integer :field_of_study
    t.integer :start_date
    t.integer :end_date
    t.integer :degree
    t.integer :activities
    t.integer :notes
  end

  create_table :courses do |t|
    t.integer :id
    t.integer :name
    t.integer :number
  end

  create_table :volunteer_experience do |t|
    t.integer :id
    t.integer :role
    t.integer :organization_name
    t.integer :cause_name
  end

  create_table :recommendations do |t|
    t.integer :id
    t.integer :recommendation_type
    t.integer :reccomendation_text
    t.integer :recommender
  end
end
