#!/usr/bin/env ruby
# sensor.rb
# Author: Andy Bettisworth
# Created At: 2015 0605 004632
# Modified At: 2015 0605 004632
# Description: manage all local sensor code

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'environ/environ'

module Environ
  # manage all local sensor code
  class Sensor
    include Admin

    SENSOR_DIR = File.join(HOME, 'GitHub', 'sensor')

    def list(sensor_regexp = false)
      sensors = get_sensors
      sensors = filter_sensors(sensors, sensor_regexp)
      sensors = sensors.sort_by { |k, v| k[:filename] }
      print_sensor_list(sensors)
      sensors
    end

    def fetch(*sensors)
      sensors = ask_for_sensor while sensors.flatten.empty?
      sensors = set_default_ext(sensors)
      sensors = get_sensor_location(sensors)
      move_sensor_to_desktop(sensors)
    end

    def clean
      sensors     = get_sensors
      sensors_out = get_open_sensors(sensors)
      sensors_out = get_sensor_location(sensors_out)

      if sensors_out
        if sensors_out.is_a? Array
          sensors_out.each { |s| system("mv #{DESKTOP}/#{File.basename(s)} #{s}") }
        else
          system("mv #{DESKTOP}/#{File.basename(sensors_out)} #{sensors_out}")
        end

        commit_changes
      end
    end

    private

    def get_sensors
      sensor_list = []

      Dir.foreach("#{SENSOR_DIR}") do |file|
        next if File.directory?("#{SENSOR_DIR}/#{file}")
        sensor = {}
        sensor = get_sensor_info("#{SENSOR_DIR}/#{file}")
        sensor_list << sensor
      end

      sensor_list
    end

    def get_sensor_info(filepath)
      sensor = {}

      dirname  = File.dirname(filepath)
      top_path = File.expand_path('..', dirname)
      language = dirname.gsub("#{top_path}/", '')

      file_head = File.open(filepath).readlines
      c = file_head[0..11].join('')

      if c.valid_encoding?
        sensor[:language] = language
        sensor[:filename] = File.basename(filepath)

        created_at = /created at:(?<created_at>.*)/i.match(c.force_encoding('UTF-8'))
        sensor[:created_at] = created_at[:created_at].strip if created_at

        modified_at = /modified at:(?<modified_at>.*)/i.match(c.force_encoding('UTF-8'))
        sensor[:modified_at] = modified_at[:modified_at].strip if modified_at

        description = /description:(?<description>.*)/i.match(c.force_encoding('UTF-8'))
        sensor[:description] = description[:description].strip if description
      else
        STDERR.puts "ERROR: Not valid UTF-8 encoding in '#{File.basename(filepath)}'"
        exit 1
      end

      sensor
    end

    def filter_sensors(sensors, sensor_regexp = false)
      pattern = Regexp.new(sensor_regexp) if sensor_regexp
      sensors.select! { |c| pattern.match(c[:filename]) } if pattern
      sensors
    end

    def print_sensor_list(sensors)
      sensors.each do |sensor|
        space = 31 - sensor[:filename].length if sensor[:filename].length < 31
        space ||= 1
        puts "#{sensor[:filename].gsub('sensor_', '')} #{' ' * space} #{sensor[:description]}"
      end
    end

    def print_file_metadata(sensor)
      puts "filename:     #{sensor[:filename]}" if sensor[:filename]
      puts "author:       #{sensor[:author]}" if sensor[:author]
      puts "created_at:   #{sensor[:created_at]}" if sensor[:created_at]
      puts "modified_at:  #{sensor[:modified_at]}" if sensor[:modified_at]
      puts "description:  #{sensor[:description]}" if sensor[:description]
    end

    def ask_for_sensor
      sensor_list = []
      puts 'What sensor do you want? [arduino_pir.c pi_xbee.py external_eeprom.c]'
      puts 'Note default extension is ANSI C (.c)'
      sensors = gets.split(/\s.*?/).flatten
      sensors.each { |c| sensor_list << c }
      sensor_list
    end

    def set_default_ext(*sensors)
      sensors.flatten!
      sensors.collect! do |sensor|
        if File.extname(sensor) == ""
          sensor += '.c'
        end
        sensor
      end

      if sensors.count <= 1
        return sensors[0]
      else
        return canvases
      end
    end

    def get_sensor_location(*sensors)
      sensor_list = get_sensors

      sensors.flatten!
      sensors.collect! do |sensor|
        sensor = set_default_ext(sensor)
        cl = sensor_list.select { |c| c[:filename] == sensor }

        if cl.count >= 1
          "#{SENSOR_DIR}/#{sensor}"
        else
          sensor
        end
      end

      if sensors.count <= 1
        return sensors[0]
      else
        return sensors
      end
    end

    def move_sensor_to_desktop(*sensors)
      sensors.flatten!
      sensors.each do |sensor|
        if File.exist?(sensor)
          system("cp #{sensor} #{DESKTOP}")
        else
          puts "No such sensor: '#{File.basename(sensor)}'"
        end
      end
    end

    def get_open_sensors(sensors)
      open_sensors = []

      Dir.foreach("#{DESKTOP}") do |entry|
        next if File.directory?(entry)
        open_sensors << entry if sensor_exist?(entry)
      end

      open_sensors
    end

    def sensor_exist?(sensor)
      sensor = set_default_ext(sensor)
      sensors = get_sensors
      sensors.select! { |s| s[:filename] == sensor }

      if sensors.count >= 1
        true
      else
        false
      end
    end

    def commit_changes
      puts 'Enter a commit message:'
      commit_msg = gets.strip
      commit_msg = "sensor clean #{Time.now.strftime('%Y%m%d%H%M%S')}" if commit_msg == ""
      system <<-CMD
        echo '';
        echo 'Committing changes for sensors...';
        cd #{SENSOR_DIR};
        git checkout annex;
        git add -A;
        git commit -m "#{commit_msg}";
      CMD
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Environ
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: sensor [options] SENSOR'

    opts.on('-l', '--list [REGXP]', 'List all matching sensor sketches') do |regexp|
      options[:list] = true
      options[:sensor_regexp] = regexp
    end

    opts.on('-n', '--new SENSOR', 'Create a new sensor sketch') do |name|
      options[:add] = name
    end

    opts.on('-f', '--fetch', 'Copy sensor sketch(es) to the Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move sensor(s) off Desktop and commit changes') do
      options[:clean] = true
    end
  end
  option_parser.parse!

  sensor = Sensor.new

  if options[:list]
    sensor.list(options[:sensor_regexp])
  elsif options[:add]
    sensor.add(options[:add])
  elsif options[:fetch]
    sensor.fetch(ARGV)
  elsif options[:clean]
    sensor.clean
  else
    puts option_parser
  end
end
