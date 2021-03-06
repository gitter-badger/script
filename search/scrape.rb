#!/usr/bin/env ruby -w
# scrape_spec.rb
# Description: Extracting view layer content from remote servers

require 'nokogiri'
require 'open-uri'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'search/search'

module Search
  # return matches of html
  class ScreenScraper
    include Admin

    attr_reader :document

    def load_url(url)
      raise 'Must supply a URI' if url.nil?
      raise 'Must supply a valid URI' unless URI.parse(url).kind_of?(URI::HTTP)
      @document = Nokogiri::HTML(open(url))
    end

    def load_file(target_file)
      raise 'Must supply a File' if target_file.nil?
      raise 'Must supply a valid File' unless File.exist?(target_file)
      raise 'Must supply an XML File' unless File.extname(target_file) == '.xml'
      file = File.open(target_file)
      @document = Nokogiri::XML(file)
      file.close
    end

    def fetch(pattern)
      raise 'Must supply a pattern' if pattern.nil?
      raise 'Must load_url() before fetching anything' if @document.nil?

      if pattern.class == String
        if pattern.match(/^<.*>$/)
          pattern.gsub!(/^</,'')
          pattern.gsub!(/>$/,'')
          @document.at_css(pattern).text
        elsif pattern.match(/\/\/.*/).nil? == false
          @document.xpath(pattern).text
        end
      elsif pattern.class == Regexp
        @document.text[pattern]
      else
        fail 'Unknown search pattern'
      end
    end
  end
end
