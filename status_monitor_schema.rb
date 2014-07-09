#!/usr/bin/ruby -w
# status_monitor_schema.rb
# Author: Andy Bettisworth
# Description: Schema for a status monitor

class StatusMonitorSchema < ActiveRecord::Base
  def change
    create_table :status_monitors do |t|
      t.integer :level_id
      t.integer :unsigned
      t.string :application
      t.text :message
      t.datetime :created_at
    end

    create_table :status_levels do |t|
      t.string :name
    end
    StatusLevel.new(name: 'debug')
    StatusLevel.new(name: 'info')
    StatusLevel.new(name: 'warn')
    StatusLevel.new(name: 'error')
    StatusLevel.new(name: 'fatal')
  end
end
