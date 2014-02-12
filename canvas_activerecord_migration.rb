#!/usr/bin/ruby -w
# canvas_activerecord_migration.rb
# Author: Andy Bettisworth
# Description: ActiveRecord, object-relational mapping put on rails

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

####################
## Simple Example ##

require 'pg' # or 'mysql2' or 'sqlite3'
require 'active_record'

conn = ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  host:     'localhost',
  database: 'graph_development',
  username: 'codebit',
  password: 'trichoderma')

class CreatePlot < ActiveRecord::Migration
  def change
    create_table :plot do |t|
      t.string  :name
      t.datetime :modified_at
      t.datetime :created_at
    end
  end
end

## Simple Example ##
####################

## SETUP database connection
## NOTE we move the connection outside the migration file per Rails convention
## [config/database.yml]
# development:
#   adapter:  'postgresql'
#   host:     'localhost'
#   database: 'graph_development'
#   username: 'codebit'
#   password: 'trichoderma'
#
# []
# > Q: need really a: probably not! # require 'rubygems'
# require 'active_record'
# require 'yaml'
# db_config = YAML::load(File.open('database.yml'))
# ActiveRecord::Base.establish_connection(db_config)

## DEBUG by logging SQL logic (output to CONSOLE)
# > Q: need really a: probably not! # require 'rubygems'
# require 'active_record'
# require 'yaml'
# require 'logger'
# db_config = YAML::load(File.open('database.yml'))
# ActiveRecord::Base.establish_connection(db_config)
# ActiveRecord::Base.logger = Logger.new(STDERR)
#
# class User < ActiveRecord::Base
# end
#
# puts User.count
#=> SQL (0.000277) SELECT count(*) AS Ccount_all FROM users
#=> 6

## DEBUG by logging SQL logic (output to FILE)
# > Q: need really a: probably not! # require 'rubygems'
# require 'active_record'
# require 'yaml'
# require 'logger'
# db_config = YAML::load(File.open('database.yml'))
# ActiveRecord::Base.establish_connection(db_config)
# ActiveRecord.colorize_logging = false
# ActiveRecord::Base.logger = Logger.new(File.open('database.log','a'))
#
# class User < ActiveRecord::Base
# end
#
# puts User.count
#=> SQL (0.000277) SELECT count(*) AS Ccount_all FROM users
#=> 6

## TODO
# > standalone migration generator
# create within /migrate directtory
# [migrate/20140212104230_camel_case_sensitive.rb]

## CONNECT to sqlite3 database
# conn = ActiveRecord::Base.establish_connection(
#   adapter:  'sqlite3',
#   database: 'flashcard_app.db')

## Q: what instance methods are there for ActiveRecord::Migration
## a: something to rake changes
## a: something to target database
#
## TEST
# plotter = CreatePlot
# puts "instance methods:\n #{plotter.instance_methods}"
#=> [:change, :disable_ddl_transaction, :verbose, :verbose=, :name, :name=,
# :version, :version=, :revert, :reverting?, :reversible, :run, :up, :down,
# :migrate, :exec_migration, :write, :announce, :say, :say_with_time,
# :suppress_messages, :connection, :method_missing, :copy, :next_migration_number,
# :blank?, :present?, :presence, :psych_to_yaml, :to_yaml, :to_yaml_properties,
# :acts_like?, :to_param, :to_query, :try, :try!, :duplicable?, :to_json,
# :instance_values, :instance_variable_names, :as_json, :require_or_load,
# :require_dependency, :load_dependency, :load, :require, :unloadable, :nil?,
# :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, :dup,
# :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze, :frozen?,
# :to_s, :inspect, :methods, :singleton_methods, :protected_methods,
# :private_methods, :public_methods, :instance_variables, :instance_variable_get,
# :instance_variable_set, :instance_variable_defined?, :remove_instance_variable,
# :instance_of?, :kind_of?, :is_a?, :tap, :send, :public_send, :respond_to?,
# :extend, :display, :method, :public_method, :singleton_method,
# :define_singleton_method, :object_id, :to_enum, :enum_for, :class_eval,
# :silence_warnings, :enable_warnings, :with_warnings, :silence_stderr,
# :silence_stream, :suppress, :capture, :silence, :quietly, :==, :equal?, :!,
# :!=, :instance_eval, :instance_exec, :__send__, :__id__]

## Q: run against database
## q: make connection to database
## a: rails has [config/database.yml] and [db/schema.rb] and [db/migrate/*]
#
## TEST
# plotter = CreatePlot.new
# plotter.try
#=> `respond_to?': nil is not a symbol (TypeError)
# plotter.try!
#=> `public_send': no method name given (ArgumentError)
# plotter.exec_migration
#=> `exec_migration': wrong number of arguments (0 for 2) (ArgumentError)
## NOTE exec_migration(conn, direction)
# plotter.exec_migration(conn,'up')
#
# [$psql plot_development && \dt]
# Schema |       Name        | Type  |  Owner
# --------+-------------------+-------+---------
#  public | schema_migrations | table | codebit
# (1 row)
#
## NOTE realized i had forgotten to add '.new()' method to CreatePlot migration
# plotter.exec_migration(conn,'down')
#=> undefined method `create_table' for #<CreatePlot:0xb95dc1cc> (NoMethodError)

# ## ActiveRecord::Migration < Object
# (from gem activerecord-4.0.2)
# ------------------------------------------------------------------------------
# ## Active Record Migrations

# Migrations can manage the evolution of a schema used by several physical
# databases. It's a solution to the common problem of adding a field to make a
# new feature work in your local database, but being unsure of how to push that
# change to other developers and to the production server. With migrations, you
# can describe the transformations in self-contained classes that can be checked
# into version control systems and executed against another database that might
# be one, two, or five versions behind.

# Example of a simple migration:

#   class AddSsl < ActiveRecord::Migration
#     def up
#       add_column :accounts, :ssl_enabled, :boolean, default: true
#     end

#     def down
#       remove_column :accounts, :ssl_enabled
#     end
#   end

# This migration will add a boolean flag to the accounts table and remove it if
# you're backing out of the migration. It shows how all migrations have two
# methods up and down that describes the transformations required to implement
# or remove the migration. These methods can consist of both the migration
# specific methods like add_column and remove_column, but may also contain
# regular Ruby code for generating data needed for the transformations.

# Example of a more complex migration that also needs to initialize data:

#   class AddSystemSettings < ActiveRecord::Migration
#     def up
#       create_table :system_settings do |t|
#         t.string  :name
#         t.string  :label
#         t.text    :value
#         t.string  :type
#         t.integer :position
#       end

#       SystemSetting.create  name:  'notice',
#                             label: 'Use notice?',
#                             value: 1
#     end

#     def down
#       drop_table :system_settings
#     end
#   end

# This migration first adds the system_settings table, then creates the very
# first row in it using the Active Record model that relies on the table. It
# also uses the more advanced create_table syntax where you can specify a
# complete table schema in one block call.

## Available Transformations

# * create_table(name, options): Creates a table called name and makes the table
#   object available to a block that can then add columns to it, following the
#   same format as add_column. See example above. The options hash is for
#   fragments like "DEFAULT CHARSET=UTF-8" that are appended to the create table
#   definition.
#
# * add_column(table_name, column_name, type, options): Adds a new column to the
#   table called table_name named column_name specified to be one of the
#   following types: :string, :text, :integer, :float, :decimal, :datetime,
#   :timestamp, :time, :date, :binary, :boolean. A default value can be
#   specified by passing an options hash like { default: 11 }. Other options
#   include :limit and :null (e.g. { limit: 50, null: false }) -- see
#   ActiveRecord::ConnectionAdapters::TableDefinition#column for details.
#
# * add_index(table_name, column_names, options): Adds a new index with the name
#   of the column. Other options include :name, :unique (e.g. { name:
#   'users_name_index', unique: true }) and :order (e.g. { order: { name: :desc
#   } }).
#
# * change_table(name, options): Allows to make column alterations to the table
#   called name. It makes the table object available to a block that can then
#   add/remove columns, indexes or foreign keys to it.
#
# * rename_table(old_name, new_name): Renames the table called old_name to
#   new_name.
#
# * rename_column(table_name, column_name, new_column_name): Renames a column
#   but keeps the type and content.
#
# * change_column(table_name, column_name, type, options):  Changes the column
#   to a different type using the same parameters as add_column.
#
# * remove_column(table_name, column_names): Removes the column listed in
#   column_names from the table called table_name.
#
# * remove_index(table_name, column: column_name): Removes the index specified
#   by column_name.
#
# * remove_index(table_name, name: index_name): Removes the index specified by
#   index_name.
#
# * drop_table(name): Drops the table called name.

# == IIrrrreevveerrssiibbllee  ttrraannssffoorrmmaattiioonnss

# Some transformations are destructive in a manner that cannot be reversed.
# Migrations of that kind should raise an ActiveRecord::IrreversibleMigration
# exception in their down method.

# == RRuunnnniinngg  mmiiggrraattiioonnss  ffrroomm  wwiitthhiinn  RRaaiillss

# The Rails package has several tools to help create and apply migrations.

# To generate a new migration, you can use
#   rails generate migration MyNewMigration

# where MyNewMigration is the name of your migration. The generator will create
# an empty migration file timestamp_my_new_migration.rb in the db/migrate/
# directory where timestamp is the UTC formatted date and time that the
# migration was generated.

# You may then edit the up and down methods of MyNewMigration.

# There is a special syntactic shortcut to generate migrations that add fields
# to a table.

#   rails generate migration add_fieldname_to_tablename fieldname:string

# This will generate the file timestamp_add_fieldname_to_tablename, which will
# look like this:
#   class AddFieldnameToTablename < ActiveRecord::Migration
#     def up
#       add_column :tablenames, :fieldname, :string
#     end

#     def down
#       remove_column :tablenames, :fieldname
#     end
#   end

# To run migrations against the currently configured database, use rake
# db:migrate. This will update the database by running all of the pending
# migrations, creating the schema_migrations table (see "About the
# schema_migrations table" section below) if missing. It will also invoke the
# db:schema:dump task, which will update your db/schema.rb file to match the
# structure of your database.

# To roll the database back to a previous migration version, use rake db:migrate
# VERSION=X where X is the version to which you wish to downgrade. If any of the
# migrations throw an ActiveRecord::IrreversibleMigration exception, that step
# will fail and you'll have some manual work to do.

# == DDaattaabbaassee  ssuuppppoorrtt

# Migrations are currently supported in MySQL, PostgreSQL, SQLite, SQL Server,
# Sybase, and Oracle (all supported databases except DB2).

# == MMoorree  eexxaammpplleess

# Not all migrations change the schema. Some just fix the data:

#   class RemoveEmptyTags < ActiveRecord::Migration
#     def up
#       Tag.all.each { |tag| tag.destroy if tag.pages.empty? }
#     end

#     def down
#       # not much we can do to restore deleted data
#       raise ActiveRecord::IrreversibleMigration, "Can't recover the deleted tags"
#     end
#   end

# Others remove columns when they migrate up instead of down:

#   class RemoveUnnecessaryItemAttributes < ActiveRecord::Migration
#     def up
#       remove_column :items, :incomplete_items_count
#       remove_column :items, :completed_items_count
#     end

#     def down
#       add_column :items, :incomplete_items_count
#       add_column :items, :completed_items_count
#     end
#   end

# And sometimes you need to do something in SQL not abstracted directly by
# migrations:

#   class MakeJoinUnique < ActiveRecord::Migration
#     def up
#       execute "ALTER TABLE `pages_linked_pages` ADD UNIQUE `page_id_linked_page_id` (`page_id`,`linked_page_id`)"
#     end

#     def down
#       execute "ALTER TABLE `pages_linked_pages` DROP INDEX `page_id_linked_page_id`"
#     end
#   end

# == UUssiinngg  aa  mmooddeell  aafftteerr  cchhaannggiinngg  iittss  ttaabbllee

# Sometimes you'll want to add a column in a migration and populate it
# immediately after. In that case, you'll need to make a call to
# Base#reset_column_information in order to ensure that the model has the latest
# column data from after the new column was added. Example:

#   class AddPeopleSalary < ActiveRecord::Migration
#     def up
#       add_column :people, :salary, :integer
#       Person.reset_column_information
#       Person.all.each do |p|
#         p.update_attribute :salary, SalaryCalculator.compute(p)
#       end
#     end
#   end

# == CCoonnttrroolllliinngg  vveerrbboossiittyy

# By default, migrations will describe the actions they are taking, writing them
# to the console as they happen, along with benchmarks describing how long each
# step took.

# You can quiet them down by setting ActiveRecord::Migration.verbose = false.

# You can also insert your own messages and benchmarks by using the
# say_with_time method:

#   def up
#     ...
#     say_with_time "Updating salaries..." do
#       Person.all.each do |p|
#         p.update_attribute :salary, SalaryCalculator.compute(p)
#       end
#     end
#     ...
#   end

# The phrase "Updating salaries..." would then be printed, along with the
# benchmark for the block when the block completes.

# == AAbboouutt  tthhee  sscchheemmaa__mmiiggrraattiioonnss  ttaabbllee

# Rails versions 2.0 and prior used to create a table called schema_info when
# using migrations. This table contained the version of the schema as of the
# last applied migration.

# Starting with Rails 2.1, the schema_info table is (automatically) replaced by
# the schema_migrations table, which contains the version numbers of all the
# migrations applied.

# As a result, it is now possible to add migration files that are numbered lower
# than the current schema version: when migrating up, those never-applied
# "interleaved" migrations will be automatically applied, and when migrating
# down, never-applied "interleaved" migrations will be skipped.

# == TTiimmeessttaammppeedd  MMiiggrraattiioonnss

# By default, Rails generates migrations that look like:

#   20080717013526_your_migration_name.rb

# The prefix is a generation timestamp (in UTC).

# If you'd prefer to use numeric prefixes, you can turn timestamped migrations
# off by setting:

#   config.active_record.timestamped_migrations = false

# In application.rb.

# == RReevveerrssiibbllee  MMiiggrraattiioonnss

# Starting with Rails 3.1, you will be able to define reversible migrations.
# Reversible migrations are migrations that know how to go down for you. You
# simply supply the up logic, and the Migration system will figure out how to
# execute the down commands for you.

# To define a reversible migration, define the change method in your migration
# like this:

#   class TenderloveMigration < ActiveRecord::Migration
#     def change
#       create_table(:horses) do |t|
#         t.column :content, :text
#         t.column :remind_at, :datetime
#       end
#     end
#   end

# This migration will create the horses table for you on the way up, and
# automatically figure out how to drop the table on the way down.

# Some commands like remove_column cannot be reversed.  If you care to define
# how to move up and down in these cases, you should define the up and down
# methods as before.

# If a command cannot be reversed, an ActiveRecord::IrreversibleMigration
# exception will be raised when the migration is moving down.

# For a list of commands that are reversible, please see
# ActiveRecord::Migration::CommandRecorder.

## Transactional Migrations

# If the database adapter supports DDL transactions, all migrations will
# automatically be wrapped in a transaction. There are queries that you can't
# execute inside a transaction though, and for these situations you can turn the
# automatic transactions off.

#   class ChangeEnum < ActiveRecord::Migration
#     disable_ddl_transaction!

#     def up
#       execute "ALTER TYPE model_size ADD VALUE 'new_value'"
#     end
#   end

# Remember that you can still open your own transactions, even if you are in a
# Migration with self.disable_ddl_transaction!.
# ------------------------------------------------------------------------------

## Class methods
#   check_pending!
#   disable_ddl_transaction!
#   migrate
#   new

## Instance methods
#   announce
#   connection
#   copy
#   down
#   exec_migration
#   execute_block
#   method_missing
#   migrate
#   name
#   next_migration_number
#   reversible
#   revert
#   reverting?
#   run
#   say
#   say_with_time
#   suppress_messages
#   up
#   version
#   write

## Attributes
#   attr_accessor name
#   attr_accessor version
