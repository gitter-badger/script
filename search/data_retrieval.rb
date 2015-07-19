#!/usr/bin/env ruby -w
# data_retrieval.rb
# Author: Andy Bettisworth
# Description: Fetch content across the interwebs

require 'open-uri'

require_relative 'search'

module Search
  # Grab some internet content
  class DataRetriever
    attr_reader :content

    def set_content(target_url)
      raise 'Warning: must supply target_url' if target_url.nil?
      raise 'Warning: target_url must be valid URI' unless URI.parse(target_url).kind_of?(URI::HTTP)
      @content = `curl #{target_url}`
    end

    def save_to_file(target_file, action)
      raise 'Warning: content must be set' if @content.nil?
      raise 'Warning: must supply target_file' if target_file.nil?
      File.open(target_file,action) do |file|
        file.write(@content)
      end
    end

    def save_to_db(database, host, username, password)
      raise "Warning: content must be set" if @content.nil?
      if database.nil? || host.nil? || username.nil? || password.nil?
        raise "Warning: must include target database, host, username, and password"
      end
      # > test database exist
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Search

  retriever = DataRetriever.new
  retriever.set_content('https://news.google.com/')
end
