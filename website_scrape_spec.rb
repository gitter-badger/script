#!/usr/bin/env ruby -w
# scrape_spec.rb
# Description: Extracting view layer content from remote servers

class ScreenScraper
  require 'nokogiri'
  require 'open-uri'

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

## USAGE
# scrape accreu.com
  #=> Created accreu_com_scrape-201401301300
# scrape news.google.com /^Headlines/
  #=> Created news_google_com_scrape-201401301330
# scrape -o featured_products.txt amazon.com //h3/a
  #=> Created featured_products.txt
# scrape -o movie_night.txt ~/Desktop/imdb.xml <movie_title>
  #=> Created movie_night.txt

describe "Screen Scraper" do
  context "search with Regex" do
    it "should fetch content from accessible URLs" do
      scrappy = ScreenScraper.new
      target_url = "http://www.amazon.com/"
      scrappy.load_url(target_url)
      gift = scrappy.fetch(/^Amazon/)
      gift.should_not be_nil
    end
    
    it "should fetch content from accessible Files"
  end
  
  context "search with XPath" do
    it "should fetch content from accessible URLs" do
      scrappy = ScreenScraper.new
      target_url = "http://www.amazon.com/"
      scrappy.load_url(target_url)
      gift = scrappy.fetch('//h3/a')
      gift.should_not be_nil
    end 
    
    it "should fetch content from accessible Files" do
      scrappy = ScreenScraper.new
      target_file = File.open("/home/wurde/Desktop/test.xml","w+")
      scrappy.load_file(target_file)
      scrappy.document.should_not be_nil
    end3
  end
  
  context "search with CSS" do
    it "should fetch content from accessible URLs" do
      scrappy = ScreenScraper.new
      target_url = "http://www.amazon.com/"
      scrappy.load_url(target_url)
      gift = scrappy.fetch("<title>")
      gift.should_not be_nil
    end
    
    it "should fetch content from accessible Files"
  end
end
