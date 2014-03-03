#!/usr/bin/ruby -w
# canvas_activerecord.rb
# Author: Andy Bettisworth
# Description: ActiveRecord, object-relational mapping put on rails

## GOALS
##  CRUD actions on our databases
##  Build associations (models connected to other models)

## FEATURES
## [0] Automated mapping between classes and tables, attributes and columns.
## [1] Associations between objects defined by simple class methods.
## [2] Aggregations of value objects.
## [3] Validation rules that can differ for new or existing objects.
## [4] Callbacks available for the entire life cycle
##      (instantiation, saving, destroying, validating, etc.).
## [5] Inheritance hierarchies.
## [6] Transactions.
## [7] Reflections on columns, associations, and aggregations.
## [8] Database abstraction through simple adapters.
## [9] Logging support for Log4r and Logger.
## [10] Database agnostic schema management with Migrations.

######################
### Simple Example ###
# require 'pg'
# require 'active_record'

# ActiveRecord::Base.establish_connection(
#   adapter:  'postgresql', # or 'mysql2' or 'sqlite3'
#   host:     'localhost',
#   database: 'accreu_development',
#   username: 'wurde',
#   password: 'trichoderma'
# )

# class Orbit < ActiveRecord::Base
# end

# ## READ all
# puts Orbit.all
# #=> #<Orbit:0xb96582cc>
# #=> ...

# ## CREATE one new orbit
# my_post = Orbit.new
### Simple Example ###
######################


################################
## ActiveRecord for ~/.script ##

# [log/database.log]
# [config/database.yml]
  # adapter:    postgresql
  # host:       localhost
  # database:   my_database
  # username:   codebit
  # password:   trichoderma

# [db/schema.rb]
# require 'active_record'
# require 'pg'
# require 'yaml'
# require 'logger'

# ActiveRecord::Base.logger = Logger.new('log/database.log')
# ActiveRecord::Base.establish_connection(YAML.load_file('config/database.yml'))

# ActiveRecord::Schema.define do
#   create_table :my_table do |t|
#     t.integer :col_int, null: false
#     t.text    :col_text
#   end
# end

## ActiveRecord for ~/.script ##
################################

## > Q: how to validate data in/out
## > Q: how to reverse engineer the schema of a database

# ## [0]
# class Product < ActiveRecord::Base
# end
# CREATE TABLE products (
#   id int(11) NOT NULL auto_increment,
#   name varchar(255),
#   PRIMARY KEY  (id)
# );
# ## This would also define the following accessors:
# ##  `Product#name` and
# ##  `Product#name=(new_name)`

# ## [1]
# class Firm < ActiveRecord::Base
#   has_many   :clients
#   has_one    :account
#   belongs_to :conglomerate
# end

# ## [2]
# class Account < ActiveRecord::Base
#   composed_of :balance, class_name: 'Money',
#               mapping: %w(balance amount)
#   composed_of :address,
#               mapping: [%w(address_street street), %w(address_city city)]
# end

# ## [3]
# class Account < ActiveRecord::Base
#   validates :subdomain, :name, :email_address, :password, presence: true
#   validates :subdomain, uniqueness: true
#   validates :terms_of_service, acceptance: true, on: :create
#   validates :password, :email_address, confirmation: true, on: :create
# end

# ## [4]
# class Person < ActiveRecord::Base
#   before_destroy :invalidate_payment_plan
# end

# ## [5]
# class Company < ActiveRecord::Base; end
# class Firm < Company; end
# class Client < Company; end
# class PriorityClient < Client; end

# ## [6]
# Account.transaction do
#   david.withdrawal(100)
#   mary.deposit(100)
# end

# ## [7]
# reflection = Firm.reflect_on_association(:clients)
# reflection.klass
# Firm.columns

# ## [8]
# ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
#                                         database: 'dbfile.sqlite3')
# ActiveRecord::Base.establish_connection(
#   adapter:  'mysql2',
#   host:     'localhost',
#   username: 'me',
#   password: 'secret',
#   database: 'activerecord'
# )

# ## [9]
# ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
# ActiveRecord::Base.logger = Log4r::Logger.new('Application Log')

# ## [10]
# class AddSystemSettings < ActiveRecord::Migration
#   def up
#     create_table :system_settings do |t|
#       t.string  :name
#       t.string  :label
#       t.text    :value
#       t.string  :type
#       t.integer :position
#     end

#     SystemSetting.create name: 'notice', label: 'Use notice?', value: 1
#   end

#   def down
#     drop_table :system_settings
#   end
# end

## Search by Date Range
# Album.where(created_at: 2.days.ago..Time.now)
# Which will generate the following SQL query (depending on the database):
# SELECT "albums".* FROM "albums"
# WHERE ("albums"."created_at"
# BETWEEN '2012-04-28 11:10:22.780712' AND '2012-04-30 11:10:22.780907')

########################
### ri documentation ###

# ## ActiveRecord::Base < Object
# ------------------------------------------------------------------------------
# ## Includes:
# (from gem activerecord-4.0.2)
#   Persistence
#   ReadonlyAttributes
#   ModelSchema
#   Inheritance
#   Scoping
#   Sanitization
#   AttributeAssignment
#   ActiveModel::Conversion
#   Integration
#   Validations
#   CounterCache
#   Locking::Optimistic
#   Locking::Pessimistic
#   AttributeMethods
#   Callbacks
#   Timestamp
#   Associations
#   ActiveModel::SecurePassword
#   AutosaveAssociation
#   NestedAttributes
#   Aggregations
#   Transactions
#   Reflection
#   Serialization
#   Store
#   Core

# ------------------------------------------------------------------------------
# ## Extended:
# (from gem activerecord-4.0.2)
#   ActiveModel::Naming
#   ActiveSupport::Benchmarkable
#   ActiveSupport::DescendantsTracker
#   ConnectionHandling
#   QueryCache::ClassMethods
#   Querying
#   Translation
#   DynamicMatchers
#   Explain

# (from gem activerecord-4.0.2)
# ------------------------------------------------------------------------------
# ## Active Record

# Active Record objects don't specify their attributes directly, but rather
# infer them from the table definition with which they're linked. Adding,
# removing, and changing attributes and their type is done directly in the
# database. Any change is instantly reflected in the Active Record objects. The
# mapping that binds a given Active Record class to a certain database table
# will happen automatically in most common cases, but can be overwritten for the
# uncommon ones.

# See the mapping rules in table_name and the full example in
# link:files/activerecord/README_rdoc.html for more insight.

# RenameFile.new

## CREATION
# Active Records accept constructor parameters either in a hash or as a block.
# The hash method is especially useful when you're receiving the data from
# somewhere else, like an HTTP request. It works like this:
#
# [1]
#   user = User.new(name: "David", occupation: "Code Artist")
#   user.name # => "David"

# You can also use block initialization:
# [2]
#   user = User.new do |u|
#     u.name = "David"
#     u.occupation = "Code Artist"
#   end

# And of course you can just create a bare object and specify the attributes
# after the fact:
# [3]
#   user = User.new
#   user.name = "David"
#   user.occupation = "Code Artist"

# ## CONDITIONS

# Conditions can either be specified as a string, array, or hash representing
# the WHERE-part of an SQL statement. The array form is to be used when the
# condition input is tainted and requires sanitization. The string form can be
# used for statements that don't involve tainted data. The hash form works much
# like the array form, except only equality and range is possible. Examples:

#   class User < ActiveRecord::Base
#     def self.authenticate_unsafely(user_name, password)
#       where("user_name = '#{user_name}' AND password = '#{password}'").first
#     end

#     def self.authenticate_safely(user_name, password)
#       where("user_name = ? AND password = ?", user_name, password).first
#     end

#     def self.authenticate_safely_simply(user_name, password)
#       where(user_name: user_name, password: password).first
#     end
#   end

# The authenticate_unsafely method inserts the parameters directly into the
# query and is thus susceptible to SQL-injection attacks if the user_name and
# password parameters come directly from an HTTP request. The
# authenticate_safely and authenticate_safely_simply both will sanitize the
# user_name and password before inserting them in the query, which will ensure
# that an attacker can't escape the query and fake the login (or worse).

# When using multiple parameters in the conditions, it can easily become hard to
# read exactly what the fourth or fifth question mark is supposed to represent.
# In those cases, you can resort to named bind variables instead. That's done by
# replacing the question marks with symbols and supplying a hash with values for
# the matching symbol keys:

#   Company.where(
#     "id = :id AND name = :name AND division = :division AND created_at > :accounting_date",
#     { id: 3, name: "37signals", division: "First", accounting_date: '2005-01-01' }
#   ).first

# Similarly, a simple hash without a statement will generate conditions based on
# equality with the SQL AND operator. For instance:

#   Student.where(first_name: "Harvey", status: 1)
#   Student.where(params[:student])

# A range may be used in the hash to use the SQL BETWEEN operator:

#   Student.where(grade: 9..12)

# An array may be used in the hash to use the SQL IN operator:

#   Student.where(grade: [9,11,12])

# When joining tables, nested hashes or keys written in the form
# 'table_name.column_name' can be used to qualify the table name of a particular
# condition. For instance:

#   Student.joins(:schools).where(schools: { category: 'public' })
#   Student.joins(:schools).where('schools.category' => 'public' )

# ## OVERWRITING DEFAULT ACCESSORS

# All column values are automatically available through basic accessors on the
# Active Record object, but sometimes you want to specialize this behavior. This
# can be done by overwriting the default accessors (using the same name as the
# attribute) and calling read_attribute(attr_name) and
# write_attribute(attr_name, value) to actually change things.

#   class Song < ActiveRecord::Base
#     # Uses an integer of seconds to hold the length of the song

#     def length=(minutes)
#       write_attribute(:length, minutes.to_i * 60)
#     end

#     def length
#       read_attribute(:length) / 60
#     end
#   end

# You can alternatively use self[:attribute]=(value) and self[:attribute]
# instead of write_attribute(:attribute, value) and read_attribute(:attribute).

# ## ATTRIBUTE QUERY METHODS

# In addition to the basic accessors, query methods are also automatically
# available on the Active Record object. Query methods allow you to test whether
# an attribute value is present.

# For example, an Active Record User with the name attribute has a name? method
# that you can call to determine whether the user has a name:

#   user = User.new(name: "David")
#   user.name? # => true

#   anonymous = User.new(name: "")
#   anonymous.name? # => false

# ## ACCESSING ATTRIBUTES BEFORE THEY HAVE BEEN TYPECASTED

# Sometimes you want to be able to read the raw attribute data without having
# the column-determined typecast run its course first. That can be done by using
# the <attribute>_before_type_cast accessors that all attributes have. For
# example, if your Account model has a balance attribute, you can call
# account.balance_before_type_cast or account.id_before_type_cast.

# This is especially useful in validation situations where the user might supply
# a string for an integer field and you want to display the original string back
# in an error message. Accessing the attribute normally would typecast the
# string to 0, which isn't what you want.

## DYNAMIC ATTRIBUTES BASED FINDERS

# Dynamic attribute-based finders are a mildly deprecated way of getting (and/or
# creating) objects by simple queries without turning to SQL. They work by
# appending the name of an attribute to find_by_ like Person.find_by_user_name.
# Instead of writing Person.find_by(user_name: user_name), you can use
# Person.find_by_user_name(user_name).

# It's possible to add an exclamation point (!) on the end of the dynamic
# finders to get them to raise an ActiveRecord::RecordNotFound error if they do
# not return any records, like Person.find_by_last_name!.

# It's also possible to use multiple attributes in the same find by separating
# them with "_a_n_d".

#   Person.find_by(user_name: user_name, password: password)
#   Person.find_by_user_name_and_password(user_name, password) # with dynamic finder

# It's even possible to call these dynamic finder methods on relations and named
# scopes.

#   Payment.order("created_on").find_by_amount(50)

# ## SAVING ARRAYS, HASHES, AND OTHER NON MAPPABLE OBJECTS IN TEXT COLUMNS
# Active Record can serialize any object in text columns using YAML. To do so,
# you must specify this with a call to the class method serialize. This makes it
# possible to store arrays, hashes, and other non-mappable objects without doing
# any additional work.

#   class User < ActiveRecord::Base
#     serialize :preferences
#   end

#   user = User.create(preferences: { "background" => "black", "display" => large })
#   User.find(user.id).preferences # => { "background" => "black", "display" => large }

# You can also specify a class option as the second parameter that'll raise an
# exception if a serialized object is retrieved as a descendant of a class not
# in the hierarchy.

#   class User < ActiveRecord::Base
#     serialize :preferences, Hash
#   end

#   user = User.create(preferences: %w( one two three ))
#   User.find(user.id).preferences    # raises SerializationTypeMismatch

# When you specify a class option, the default value for that attribute will be
# a new instance of that class.

#   class User < ActiveRecord::Base
#     serialize :preferences, OpenStruct
#   end

#   user = User.new
#   user.preferences.theme_color = "red"

## SINGLE TABLE INHERITANCE

# Active Record allows inheritance by storing the name of the class in a column
# that by default is named "type" (can be changed by overwriting
# Base.inheritance_column). This means that an inheritance looking like this:

#   class Company < ActiveRecord::Base; end
#   class Firm < Company; end
#   class Client < Company; end
#   class PriorityClient < Client; end

# When you do Firm.create(name: "37signals"), this record will be saved in the
# companies table with type = "Firm". You can then fetch this row again using
# Company.where(name: '37signals').first and it will return a Firm object.

# If you don't have a type column defined in your table, single-table
# inheritance won't be triggered. In that case, it'll work just like normal
# subclasses with no special magic for differentiating between them or reloading
# the right type with find.

# Note, all the attributes for all the cases are kept in the same table. Read
# more: http://www.martinfowler.com/eaaCatalog/singleTableInheritance.html

## CONNECTION TO MULTIPLE DATABASES IN DIFFERENT MODULES
# Connections are usually created through
# ActiveRecord::Base.establish_connection and retrieved by
# ActiveRecord::Base.connection. All classes inheriting from ActiveRecord::Base
# will use this connection. But you can also set a class-specific connection.
# For example, if Course is an ActiveRecord::Base, but resides in a different
# database, you can just say Course.establish_connection and Course and all of
# its subclasses will use this connection instead.

# This feature is implemented by keeping a connection pool in ActiveRecord::Base
# that is a Hash indexed by the class. If a connection is requested, the
# retrieve_connection method will go up the class-hierarchy until a connection
# is found in the connection pool.

## EXCEPTIONS
# * ActiveRecordError - Generic error class and superclass of all other errors
#   raised by Active Record.
#
# * AdapterNotSpecified - The configuration hash used in establish_connection
#   didn't include an :adapter key.
#
# * AdapterNotFound - The :adapter key used in establish_connection specified a
#   non-existent adapter (or a bad spelling of an existing one).
#
# * AssociationTypeMismatch - The object assigned to the association wasn't of
#   the type specified in the association definition.
#
# * AttributeAssignmentError - An error occurred while doing a mass assignment
#   through the attributes= method. You can inspect the attribute property of
#   the exception object to determine which attribute triggered the error.
#
# * ConnectionNotEstablished - No connection has been established. Use
#   establish_connection before querying.
#
# * MultiparameterAssignmentErrors - Collection of errors that occurred during a
#   mass assignment using the attributes= method. The errors property of this
#   exception contains an array of AttributeAssignmentError objects that should
#   be inspected to determine which attributes triggered the errors.
#
# * RecordInvalid - raised by save! and create! when the record is invalid.
#
# * RecordNotFound - No record responded to the find method. Either the row with
#   the given ID doesn't exist or the row didn't meet the additional
#   restrictions. Some find calls do not raise this exception to signal nothing
#   was found, please check its documentation for further details.
#
# * SerializationTypeMismatch - The serialized object wasn't of the class
#   specified as the second parameter.
#
# * StatementInvalid - The database server rejected the SQL statement. The
#   precise error is added in the message.

<<<<<<< HEAD
=======
# NNoottee: The attributes listed are class-level attributes (accessible
# from both the class and instance level). So it's possible to assign a logger
# to the class through Base.logger= which will then be used by all instances in
# the current object space.
>>>>>>> 3a4a56ab88f5b68240984f26b51e2a18e6b06612
# ------------------------------------------------------------------------------
# Also found in:
#   gem activerecord-deprecated_finders-1.0.3

# = AAccttiivveeRReeccoorrdd::::SScchheemmaa  <<  AAccttiivveeRReeccoorrdd::::MMiiggrraattiioonn

# (from gem activerecord-4.0.2)
# ------------------------------------------------------------------------------
# = AAccttiivvee  RReeccoorrdd  SScchheemmaa

# Allows programmers to programmatically define a schema in a portable DSL. This
# means you can define tables, indexes, etc. without using SQL directly, so your
# applications can more easily support multiple databases.

## Usage:
#   ActiveRecord::Schema.define do
#     create_table :authors do |t|
#       t.string :name, null: false
#     end

#     add_index :authors, :name, :unique

#     create_table :posts do |t|
#       t.integer :author_id, null: false
#       t.string :subject
#       t.text :body
#       t.boolean :private, default: false
#     end

#     add_index :posts, :author_id
#   end

# ActiveRecord::Schema is only supported by database adapters that also support
# migrations, the two features being very similar.
# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::
#   define

# = IInnssttaannccee  mmeetthhooddss::
#   migrations_paths

# = AAccttiivveeRReeccoorrdd::::CCoonnnneeccttiioonnAAddaapptteerrss::::TTaabblleeDDeeffiinniittiioonn##ccoolluummnn

# (from gem activerecord-4.0.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  TTaabblleeDDeeffiinniittiioonn
# ------------------------------------------------------------------------------
<<<<<<< HEAD
=======
# Also found in:
#   gem activerecord-deprecated_finders-1.0.3


# = AAccttiivveeRReeccoorrdd::::SScchheemmaa  <<  AAccttiivveeRReeccoorrdd::::MMiiggrraattiioonn

# (from gem activerecord-4.0.2)
# ------------------------------------------------------------------------------
# = AAccttiivvee  RReeccoorrdd  SScchheemmaa

# Allows programmers to programmatically define a schema in a portable DSL. This
# means you can define tables, indexes, etc. without using SQL directly, so your
# applications can more easily support multiple databases.

# Usage:

#   ActiveRecord::Schema.define do
#     create_table :authors do |t|
#       t.string :name, null: false
#     end

#     add_index :authors, :name, :unique

#     create_table :posts do |t|
#       t.integer :author_id, null: false
#       t.string :subject
#       t.text :body
#       t.boolean :private, default: false
#     end

#     add_index :posts, :author_id
#   end

# ActiveRecord::Schema is only supported by database adapters that also support
# migrations, the two features being very similar.
# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::
#   define

# = IInnssttaannccee  mmeetthhooddss::
#   migrations_paths

# = AAccttiivveeRReeccoorrdd::::CCoonnnneeccttiioonnAAddaapptteerrss::::TTaabblleeDDeeffiinniittiioonn##ccoolluummnn

# (from gem activerecord-4.0.2)
# === IImmpplleemmeennttaattiioonn  ffrroomm  TTaabblleeDDeeffiinniittiioonn
# ------------------------------------------------------------------------------
>>>>>>> 3a4a56ab88f5b68240984f26b51e2a18e6b06612
#   column(name, type, options = {})

# ------------------------------------------------------------------------------

# Instantiates a new column for the table. The type parameter is normally one of
# the migrations native types, which is one of the following: :primary_key,
# :string, :text, :integer, :float, :decimal, :datetime, :timestamp, :time,
# :date, :binary, :boolean.

# You may use a type not in this list as long as it is supported by your
# database (for example, "polygon" in MySQL), but this will not be database
# agnostic and should usually be avoided.

# Available options are (none of these exists by default):
# * :limit - Requests a maximum column length. This is number of characters for
#   :string and :text columns and number of bytes for :binary and :integer
#   columns.
# * :default - The column's default value. Use nil for NULL.
# * :null - Allows or disallows NULL values in the column. This option could
#   have been named :null_allowed.
# * :precision - Specifies the precision for a :decimal column.
# * :scale - Specifies the scale for a :decimal column.

# For clarity's sake: the precision is the number of significant digits, while
# the scale is the number of digits that can be stored following the decimal
# point. For example, the number 123.45 has a precision of 5 and a scale of 2. A
# decimal with a precision of 5 and a scale of 2 can range from -999.99 to
# 999.99.

# Please be aware of different RDBMS implementations behavior with :decimal
# columns:
# * The SQL standard says the default scale should be 0, :scale <= :precision,
#   and makes no comments about the requirements of :precision.
# * MySQL: :precision [1..63], :scale [0..30]. Default is (10,0).
# * PostgreSQL: :precision [1..infinity], :scale [0..infinity]. No default.
# * SQLite2: Any :precision and :scale may be used. Internal storage as strings.
#   No default.
# * SQLite3: No restrictions on :precision and :scale, but the maximum supported
#   :precision is 16. No default.
# * Oracle: :precision [1..38], :scale [-84..127]. Default is (38,0).
# * DB2: :precision [1..63], :scale [0..62]. Default unknown.
# * Firebird: :precision [1..18], :scale [0..18]. Default (9,0). Internal types
#   NUMERIC and DECIMAL have different storage rules, decimal being better.
# * FrontBase?: :precision [1..38], :scale [0..38]. Default (38,0). WARNING Max
#   :precision/:scale for NUMERIC is 19, and DECIMAL is 38.
# * SqlServer?: :precision [1..38], :scale [0..38]. Default (38,0).
# * Sybase: :precision [1..38], :scale [0..38]. Default (38,0).
# * OpenBase?: Documentation unclear. Claims storage in double.

# This method returns self.

# == EExxaammpplleess
#   # Assuming +td+ is an instance of TableDefinition
#   td.column(:granted, :boolean)
#   # granted BOOLEAN

#   td.column(:picture, :binary, limit: 2.megabytes)
#   # => picture BLOB(2097152)

#   td.column(:sales_stage, :string, limit: 20, default: 'new', null: false)
#   # => sales_stage VARCHAR(20) DEFAULT 'new' NOT NULL

#   td.column(:bill_gates_money, :decimal, precision: 15, scale: 2)
#   # => bill_gates_money DECIMAL(15,2)

#   td.column(:sensor_reading, :decimal, precision: 30, scale: 20)
#   # => sensor_reading DECIMAL(30,20)

#   # While <tt>:scale</tt> defaults to zero on most databases, it
#   # probably wouldn't hurt to include it.
#   td.column(:huge_integer, :decimal, precision: 30)
#   # => huge_integer DECIMAL(30)

#   # Defines a column with a database-specific type.
#   td.column(:foo, 'polygon')
#   # => foo polygon

# == SShhoorrtt--hhaanndd  eexxaammpplleess

# Instead of calling column directly, you can also work with the short-hand
# definitions for the default types. They use the type as the method name
# instead of as a parameter and allow for multiple columns to be defined in a
# single statement.

# What can be written like this with the regular calls to column:
<<<<<<< HEAD
=======

>>>>>>> 3a4a56ab88f5b68240984f26b51e2a18e6b06612
#   create_table :products do |t|
#     t.column :shop_id,    :integer
#     t.column :creator_id, :integer
#     t.column :name,       :string, default: "Untitled"
#     t.column :value,      :string, default: "Untitled"
#     t.column :created_at, :datetime
#     t.column :updated_at, :datetime
#   end

# can also be written as follows using the short-hand:
<<<<<<< HEAD
=======

>>>>>>> 3a4a56ab88f5b68240984f26b51e2a18e6b06612
#   create_table :products do |t|
#     t.integer :shop_id, :creator_id
#     t.string  :name, :value, default: "Untitled"
#     t.timestamps
#   end

# There's a short-hand method for each of the type values declared at the top.
# And then there's TableDefinition#timestamps that'll add created_at and
# updated_at as datetimes.

# TableDefinition#references will add an appropriately-named _id column, plus a
# corresponding _type column if the :polymorphic option is supplied. If
# :polymorphic is a hash of options, these will be used when creating the _type
# column. The :index option will also create an index, similar to calling
# add_index. So what can be written like this:

#   create_table :taggings do |t|
#     t.integer :tag_id, :tagger_id, :taggable_id
#     t.string  :tagger_type
#     t.string  :taggable_type, default: 'Photo'
#   end
#   add_index :taggings, :tag_id, name: 'index_taggings_on_tag_id'
#   add_index :taggings, [:tagger_id, :tagger_type]

# Can also be written as follows using references:
<<<<<<< HEAD
=======

>>>>>>> 3a4a56ab88f5b68240984f26b51e2a18e6b06612
#   create_table :taggings do |t|
#     t.references :tag, index: { name: 'index_taggings_on_tag_id' }
#     t.references :tagger, polymorphic: true, index: true
#     t.references :taggable, polymorphic: { default: 'Photo' }
#   end
<<<<<<< HEAD
=======


>>>>>>> 3a4a56ab88f5b68240984f26b51e2a18e6b06612
