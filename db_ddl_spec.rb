require 'pg'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:    'postgresql',
  host:       'localhost',
  database:   'olympics',
  username:   'codebit',
  password:   'trichoderma')

ActiveRecord::Schema.define do
end

## DATATYPES
# :primary_key,
# :binary, :boolean,
# :integer, :float, :decimal,
# :string, :text,
# :datetime, :timestamp, :time, :date,

## OPTIONS
# * :limit - Requests a maximum column length.
#       Number of characters for :string and :text columns and
#       Number of bytes for :binary and :integer columns.
# * :default - The column's default value. Use nil for NULL.
# * :null - Allows or disallows NULL values in the column.
# * :precision - Specifies the precision for a :decimal column.
# * :scale - Specifies the scale for a :decimal column.

## TRANSFORMATIONS
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
