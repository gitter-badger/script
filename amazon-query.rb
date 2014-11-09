#!/usr/bin/env ruby -w
# amazon-query.rb
# Author: Andy Bettisworth
# Created At: 2014 1107 174313
# Modified At: 2014 1107 174313
# Description: Query Amazon Product API
# http://docs.aws.amazon.com/AWSECommerceService/latest/DG/Welcome.html

require 'vacuum'
require 'optparse'
require 'open3'

class AmazonQuery
  LOCALE = ['BR','CA','CN','DE','ES','FR','GB','IN','IT','JP','US']

  attr_accessor :request

  def initialize(locale=nil)
    if LOCALE.include?(locale)
      @request = Vacuum.new(locale)
    else
      @request = Vacuum.new
    end

    @request.configure(
      aws_access_key_id:     'AKIAJ642JMWDFLXV6JVA',
      aws_secret_access_key: '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',
      associate_tag:         'wurde'
    )
  end

  def send(index, *param)
    exit_if_no_param(param)
    exit_if_no_connection

    params = {
      'SearchIndex'   => index,
      'Keywords'      => keyword
    }

    puts "Searching for '#{keyword}' in '#{index}' on Amazon.com..."
    result = @request.item_search(query: params)
    puts result.to_h
  end

  private

  def exit_if_no_param(param)
    unless param.count > 0
      STDERR.puts <<-MSG
Your request should have atleast 1 of the following parameters:

:keywords, :title, :power, :browse_node, :artist, :author, :actor, :director,
audience_rating, :manufacturer, :music_label, :composer, :publisher, :brand,
conductor, :orchestra, :text_stream, :cuisine, :city, :neighborhood
      MSG
      exit 4
    end
  end

  def exit_if_no_connection
    stdout, stderr, status = Open3.capture3('ping -c 3 example.com')
    unless status == 0
      STDERR.puts status
      STDERR.puts stderr
      STDERR.puts 'Unable to make an internet connection. Did you forget the internet is required?'
      exit 3
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: amazon-query SEARCH_INDEX [options]"

    opts.on('-k KEYWORD', '--keyword KEYWORD', 'Search by word or phrase') do |key|
      options[:keyword] = key
    end

    opts.on('-r RESPONSE_GROUP', '--response-group RESPONSE_GROUP', 'Specifies the types of values to return') do |group|
      options[:response_group] = group
    end
  end
  option_parser.parse!

  req = AmazonQuery.new

  if ARGV.count > 0
    if options[:keyword]
      req.send(ARGV.join(' '), options[:keyword])
    else
      req.send(ARGV.join(' '))
    end
  else
    STDERR.puts <<-MSG
Missing valid SearchIndex. Possible indices include:

All, Apparel, Appliances, ArtsAndCrafts, Automotive, Baby, Beauty, Blended, Books,
Classical, Collectibles, DigitalMusic, Grocery, DVD, Electronics, HealthPersonalCare,
HomeGarden, Industrial, Jewelry, KindleStore, Kitchen, LawnGarden, Magazines,
Marketplace, Merchants, Miscellaneous, MobileApps, MP3Downloads, Music, MusicalInstruments,
MusicTracks, OfficeProducts, OutdoorLiving, PCHardware, PetSupplies, Photo, Shoes,
Software, SportingGoods, Tools, Toys, UnboxVideo, VHS, Video, VideoGames, Watches,
Wireless, WirelessAccessories

    MSG
    STDERR.puts option_parser
    exit 2
  end
end
