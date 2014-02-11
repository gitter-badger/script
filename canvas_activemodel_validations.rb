#!/usr/bin/ruby -w
# canvas_activemodel_validations.rb
# Description: Canvas ActiveModel::Validations class

## > Q: how to provide useful validation error messages
## a: including a default error_message() method to trigger on fail

## Q: Possible attribute validations
## a: length, type, pressence, regexp match
## A:
## validates :terms, acceptance: true
## validates :password, confirmation: true
## validates :username, exclusion: { in: %w(admin superuser) }
## validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
## validates :first_name, length: { maximum: 30 }
## validates :age, numericality: true
## validates :username, presence: true
## validates :username, uniqueness: true

## Add multiple validations to an attribute
# validates :password,  presence:      true,
#                       confirmation:  true,
#                       length:        { minimum: 6 }
## ~OR~
# validates :password, presence:true, confirmation:true, length:{minimum: 6}

#############
### TEST1 ###
# require 'active_model'
# class Post
#   include ActiveModel::Validations

#   attr_accessor :title, :content

#   validates :title, presence:true, length:{minimum: 6}
# end

# my_post = Post.new
# my_post.title = "You Are Cool"
# my_post.content = "This text fascinates and informs."
# puts my_post.valid?
# #=> true
# my_post.title = "You"
# puts my_post.valid?
# #=> false
#############

#######################################################
### EXAMPLE usage - validate presence of attributes ###
# require 'active_model'
# class Post
#   include ActiveModel::Validations

#   attr_accessor :title, :content

#   validates_presence_of :title, :content
# end

# our_post = Post.new
# our_post.title = "Our Cool Title"
# our_post.content = "Some nifty comments I babble about."
# puts "Is our post model passing validations? " + our_post.valid?.to_s
#######################################################

###################################################
### EXAMPLE usage - from rails/activemodel docs ###
# require 'active_model'
# class Person
#   include ActiveModel::Validations

#   attr_accessor :first_name, :last_name

#   validates_each :first_name, :last_name do |record, attr, value|
#     record.errors.add attr, 'starts with z.' if value.to_s[0] = ?z
#   end
# end

# person = Person.new
# person.first_name = 'zoolander'
# puts 'zoolander valid? ' + person.valid?.to_s
# ## > get validation to pass
# person.first_name = 'foo'
# puts 'foo valid? ' + person.valid?.to_s
###################################################
