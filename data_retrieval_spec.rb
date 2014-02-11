#!/usr/bin/env ruby -w
# data_retrieval.rb
# Description: Fetch content across the interwebs

require 'open-uri'

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

describe "Data Retriever" do
  it "should retrieve data from target URL" do
    retriever = DataRetriever.new
    target_url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_hour.geojson"
    retriever.set_content(target_url)
    retriever.content.should_not be_nil
  end

  it "should store data in target file" do
    retriever = DataRetriever.new
    target_url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_hour.geojson"
    target_file = ENV['HOME'] + "/Desktop/earthquakes-#{Time.now.strftime '%Y%m%d%H%M'}.geojson"
    action = 'w+'
    retriever.set_content(target_url)
    retriever.save_to_file(target_file,action)
    File.exist?(target_file).should be_true
    File.open(target_file,'r').read.should =~ /earthquake/
  end

  it "should store data in target database" do
    retriever = DataRetriever.new
    target_url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_hour.geojson"
    database = "earthquakes"
    host = "localhost"
    username = "wurde"
    password = "trichoderma"
    # > given database exists
    retriever.save_to_db(database, host, username, password)
    # > then assert new data exists in our target database
  end
end
