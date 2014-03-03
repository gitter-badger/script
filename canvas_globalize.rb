#!/usr/bin/ruby -w
# canvas_globalize.rb
# Description: Canvas globalize gem

require 'globalize'

## NOTE github repo description
## Rails I18n de-facto standard library for ActiveRecord model/data translation.
## Globalize builds on the I18n API in Ruby on Rails
##  to add model translations to ActiveRecord models.

## REQUIRE
## ActiveRecord > 4.0.0 (see below for installation with ActiveRecord 3.x)
## I18n

##########################
### Model Translations ###

## Translate your models' attribute values.
class Post < ActiveRecord::Base
  translates :title, :text
end

## Translate the attributes :title and :text per locale:
I18n.locale = :en
post.title # => Globalize rocks!
## ~OR~
I18n.locale = :he
post.title # => גלובאלייז2 שולט!

## REQUIRED
## In order to make this work,
## you'll need to add the appropriate
## translation tables.

## Create a translation table
class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.timestamps
    end
    Post.create_translation_table! :title => :string, :text => :text
  end
  def down
    drop_table :posts
    Post.drop_translation_table!
  end
end
## ~OR~ specificy specific columns
class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.timestamps
    end
    Post.create_translation_table! :title => :string,
      :text => {:type => :text, :null => false, :default => 'abc'}
  end
  def down
    drop_table :posts
    Post.drop_translation_table!
  end
end
## REQUIRED
## Note that the ActiveRecord model Post must already exist
##  and have a translates directive listing the translated fields.

######################
### Migrating data ###

##################
### Versioning ###

#################
### Fallbacks ###

#############
### Scope ###

##################
### View Usage ###

#####################
### Interpolation ###

