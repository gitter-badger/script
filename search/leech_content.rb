#!/usr/ruby -w
# leech_content.rb
# Author: Andy Bettisworth
# Description: Fetch HTML from target URL

require 'erb'
require 'nokogiri'
require 'open-uri'

class HTMLFetcher
  TEST_TEMPLATE = 'test.html.erb'

  # GET web content
  def leech_content(url_path, nokogiri_queries = {})
    doc = Nokogiri::HTML(open(url_path), "UTF-8")
    nokogiri_queries.each do |key, value|
      puts "Retrieving: #{key}..."
      nokogiri_queries[key] = doc.xpath(value)
      puts "Found:\n#{nokogiri_queries[key]}"
      puts ""
    end
    nokogiri_queries
  end

  # CREATE HTML file using the template and data provided
  def create_html_file(filename, template, data)
    File.open(filename, "w+:utf-8") do |file|
      file << ERB.new(File.read(template)).result(data.to_binding)
    end
  end
end

if __FILE__ == $0
  fetcher = HTMLFetcher.new
  fetcher.leech_content("http://drawcrowd.com/",
    top_left_img: '//*[@id="top-ban"]/div/div/div[1]/div/div[1]/div/img',
    top_right_img: '//*[@id="top-ban"]/div/div/div[2]/div/div[1]/div/img')
end
