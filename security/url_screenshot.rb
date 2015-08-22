#!/usr/bin/ruby -w
# url_screenshot.rb
# Author: Andy Bettisworth
# Description: Capture screenshot of target URL

require 'selenium-webdriver'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'security/security'

module Security
  # grab a screenshot of a webpage
  class WebScreenshotFetcher
    include Admin
    
    def get_screenshot(target_url, target_img)
      driver = Selenium::WebDriver.for :chrome
      driver.navigate.to "http://#{target_url}"
      driver.save_screenshot(target_img)
      driver.quit
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Security
  require 'optparse'

  options = {}
  OptionParser.new do |opts|
    opts.banner = 'USAGE: get_screenshot [options]'

    opts.on('-u', '--url [PATH]', 'Set target URL') do |target_url|
      options[:url] = target_url.to_s
    end

    opts.on('-i', '--img [FILENAME]', 'Set image filename') do |target_img|
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
