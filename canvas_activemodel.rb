#!/usr/bin/ruby -w
# canvas_activemodel.rb
# Description: Canvas ActiveModel class

## [model/message.rb]
class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :content

  validates_presence_of :name
  validates_format_of :email, with: /^[-a-z0-9.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :content, maximum: 500

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end

## [message_controller.rb]
class MessageController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      flash[:notice] = "Message sent! Thank you for contacting us."
      redirect_to root_url
    else
      render action: 'new'
    end
  end
end

## MODULES
# ActiveModel::AttributeMethods
# ActiveModel::Callbacks
# ActiveModel::Conversion
# ActiveModel::Dirty
# ActiveModel::Errors
# ActiveModel::Model
# ActiveModel::Naming
# ActiveModel::Serializers
# ActiveModel::Translation
# ActiveModel::Validations
