#!/usr/bin/env ruby
# amazon-query.rb
# Author: Andy Bettisworth
# Created At: 2014 1107 174313
# Modified At: 2014 1107 174313
# Description: Query Amazon Product API
# http://docs.aws.amazon.com/AWSECommerceService/latest/DG/Welcome.html

require 'vacuum'
require 'open3'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'trade/trade'

module Trade
  # return Amazon products based on query
  class AmazonQuery
    include Admin
    
    LOCALE = ['BR','CA','CN','DE','ES','FR','GB','IN','IT','JP','US']

    attr_accessor :request

    def initialize(locale=nil)
      if LOCALE.include?(locale)
        @request = Vacuum.new(locale)
      else
        @request = Vacuum.new
      end

      @request.configure(
        aws_access_key_id:     '42JMWJVA',
        aws_secret_access_key: 'AENBs0tl',
        associate_tag:         'wurde'
      )
    end

    def send(index, xml=false, *param)
      exit_if_no_param(param)
      exit_if_no_connection

      param[0]['SearchIndex'] = index

      puts "Searching in '#{index}' on Amazon.com..."
      response = @request.item_search(query: param[0])

      if xml
        puts response.body
        return response.body
      else
        puts response.to_h
        return response.to_h
      end
    end

    private

    def exit_if_no_param(param)
      unless param.count > 0 and param[0].count > 0
        STDERR.puts <<-MSG
  Your request should have atleast 1 of the following parameters:

  Actor, Artist, AudiencRating, Author, Brand, BrowseNode, Composer, Conductor,
  Director, Keywords, Manufacturer, MusicLabel, Orchestra, Power, Publisher, Title,
  TextStream, Cuisine, City, Neighborhood

  USAGE: send(SEARCH_INDEX, {'parameter' => 'value', ..})
        MSG
        exit 4
      end
    end

    def exit_if_no_connection
      STDOUT.puts 'Testing internet connection...'
      command = 'ping -c 3 example.com'
      stdout, stderr, status = Open3.capture3(command)
      unless status.success?
        STDERR.puts "Unable to make an internet connection executing '#{command}'"
        STDERR.puts stderr.gsub(/ping: /, '')
        exit 2
      end
      STDOUT.puts 'Success!'
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Trade
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: amazon-query SEARCH_INDEX [options]'

    opts.on('--actor ACTOR', 'Name of an actor associated with the item.') do |actor|
      options[:actor] = actor
    end

    opts.on('--artist ARTIST', 'Name of an artist associated with the item.') do |artist|
      options[:artist] = artist
    end

    opts.on('--audience-rating RATING', 'Movie ratings based on MPAA ratings or age, depending upon the locale.') do |audience_rating|
      options[:audience_rating] = audience_rating
    end

    opts.on('--author AUTHOR', 'Name of an author associated with the item.') do |author|
      options[:author] = author
    end

    opts.on('--brand BRAND', 'Name of a brand associated with the item.') do |brand|
      options[:brand] = brand
    end

    opts.on('--browse_node BROWSE_NODE', 'Browse nodes are positive integers that identify product categories.') do |browse_node|
      options[:browse_node] = browse_node
    end

    opts.on('--composer COMPOSER', 'Name of an composer associated with the item.') do |composer|
      options[:composer] = composer
    end

    opts.on('--conductor CONDUCTOR', 'Name of a conductor associated with the item.') do |conductor|
      options[:conductor] = conductor
    end

    opts.on('--director DIRECTOR', 'Name of a director associated with the item.') do |director|
      options[:director] = director
    end

    opts.on('-k KEYWORDS', '--keywords KEYWORDS', 'Search by word or phrase') do |keys|
      options[:keywords] = keys
    end

    opts.on('--manufacturer MANUFACTURER', 'Name of a manufacturer associated with the item.') do |manufacturer|
      options[:manufacturer] = manufacturer
    end

    opts.on('--music_label MUSIC_LABEL', 'Name of an music label associated with the item.') do |music_label|
      options[:music_label] = music_label
    end

    opts.on('--orchestra ORCHESTRA', 'Name of an orchestra associated with the item.') do |orchestra|
      options[:orchestra] = orchestra
    end

    opts.on('--power POWER', "Performs a book search using a complex query string. Requires SearchIndex: Books") do |power|
      options[:power] = power
    end

    opts.on('--publisher PUBLISHER', 'Name of a publisher associated with the item.') do |publisher|
      options[:publisher] = publisher
    end

    opts.on('--title TITLE', 'The title associated with the item.') do |title|
      options[:title] = title
    end

    opts.on('-r RESPONSE_GROUP', '--response-group RESPONSE_GROUP', 'Specifies the types of values to return') do |group|
      options[:response_group] = group
    end

    opts.on('--xml', 'Return output in raw XML format') do
      options[:xml] = true
    end
  end
  option_parser.parse!

  req = AmazonQuery.new

  if ARGV.count > 0
    param = {}

    param['Actor'] = options[:actor] if options[:actor]
    param['Artist'] = options[:artist] if options[:artist]
    param['AudiencRating'] = options[:audience_rating] if options[:audience_rating]
    param['Author'] = options[:author] if options[:author]
    param['Brand'] = options[:brand] if options[:brand]
    param['Browse_node'] = options[:browse_node] if options[:browse_node]
    param['Composer'] = options[:composer] if options[:composer]
    param['Conductor'] = options[:conductor] if options[:conductor]
    param['Director'] = options[:director] if options[:director]
    param['Keywords'] = options[:keywords] if options[:keywords]
    param['Manufacturer'] = options[:manufacturer] if options[:manufacturer]
    param['Music_label'] = options[:music_label] if options[:music_label]
    param['Orchestra'] = options[:orchestra] if options[:orchestra]
    param['Power'] = options[:power] if options[:power]
    param['Publisher'] = options[:publisher] if options[:publisher]
    param['Title'] = options[:title] if options[:title]

    unless param.count > 0
      STDERR.puts <<-MSG
Your request should have atleast 1 search parameter:

      MSG
      STDERR.puts option_parser
      exit 2
    end

    req.send(ARGV.join(' '), options[:xml], param)
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
    exit 1
  end
end
