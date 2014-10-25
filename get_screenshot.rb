#!/usr/bin/ruby -w
# get_screenshot.rb
# Author: Andy Bettisworth
# Description: Capture screenshot of target URL

require 'selenium-webdriver'
require 'optparse'

class WebScreenshotFetcher
  def get_screenshot(target_url, target_img)
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to "http://#{target_url}"
    driver.save_screenshot(target_img)
    driver.quit
  end
end

if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.banner = "USAGE: get_screenshot [options]"

    opts.on('-u',"--url [PATH]", 'Set target URL') do |target_url|
      options[:url] = target_url.to_s
    end

    opts.on('-i',"--img [FILENAME]", 'Set image filename') do |target_img|
      options[:img] = target_img.to_s
    end
  end.parse!

  snappy = WebScreenshotFetcher.new
  if options[:url]
    if options[:img]
      snappy.get_screenshot(options[:url], options[:img])
    else
      puts '!ERROR: An image filename is required. [--img]'
    end
  else
    puts '!ERROR: A target URL is required. [--url]'
  end
end