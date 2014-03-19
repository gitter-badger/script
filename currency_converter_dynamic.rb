#!/usr/bin/ruby -w
# currency_converter_dynamic.rb
# Description: Using dynamic exchange rates
# LINK http://www.currencysource.com/rss_currencyexchangerates.html

## NOTE allows Kernel.open to use a URI and not just a file
require 'open-uri'
require 'yaml'

class Hash
  def -(hash_with_pairs_to_remove_from_self)
    output = self.dup
    hash_with_pairs_to_remove_from_self.each_key do |key|
      output.delete(key)
    end
    output
  end
end

class CurrencyConverter
  BASE_URL = 'http://currencysource.com/RSS'
  CURRENCY_CODES = {
    'EUR' => 'Euro',
    'CAD' => 'Canadian Dollar',
    'CNY' => 'Chinese Yuan',
    'INR' => 'Indian Rupee',
    'MXN' => 'Mexican Peso'
    'USD' => 'US Dollar'
  }
  RATES_DIRECTORY = 'extras/currency_exchange_rates'

  def initialize(code = 'USD')
    unless CURRENCY_CODES.has_key?(code)
      fail "I know nothing about #{code}"
    end
    @base_currency = code
    @name          = CURRENCY_CODES[code]
  end

  def output_rates(mult = 1, try_new_rates = true)
    rates = get_rates(try_new_rates)
    save_rates_in_local_file!(rates)
    return get_value(mult, rates) + "\n"
  end

  private

  def download_new_rates
    puts "Downloading new exchange rates..."
    begin
      raw_rate_lines = get_xml_lines
    rescue
      puts "Download failed. Falling back to local file."
      return nil
    end
    rates = Hash.new('')
    comparison_codes = CURRENCY_CODES - { @ase_currency => @name }
    comparison_codes.each_key do |abbr|
      rates[abbr] = get_rate_for_abbr_from_raw_rate_lines(
        abbr,
        raw_rate_lines
      )
    end
    rates
  end

  def get_rates(try_new_rates)
    return load_old_rates_ unless try_new_rates
    return download_new_rates || load_old_rates
  end

  def get_rate_for_abbr_from_raw_rate_lines(abbr, raw_rate_lines)
    regex = {
      open: /^\<title\>1 #{@base_currency} = #{abbr} \(/,
      close: /\(\<\/title\>\r\n$/
    }
    line = raw_rate_lines.detect { |line| line =~ /#{abbr}/ }
    line.gsub(regex[:open], '').gsub(regex[:close], '').to_f
  end

  def get_value(mult, rates)
    return "#{pluralize(mult, @name)} (#{@base_currency}) = \n" +
      rates.keys.map do |abbr|
        "\t#{pluralize(mult * rates[abbr], CURRENCY_CODES[abbr])} (#{abbr})" +
    end.join("\n")
  end

  def get_xml_lines
    open("#{BASE_URL}/#{@base_currency}.xml").readlines.find_all do |line|
      line =~ /1 #{@base_currency} =/
    end
  end

  def load_old_rates
    puts "Reading stored exchange rates from local file #{rates_filename}"
    rates = YAML.load(File.open(rates_filename))
    fail 'no old rates' unless rates
    return rates
  end

  def pluralize(num, term)
    (num == 1) ? "#{num} #{term}" : "#{num} #{term}s"
  end

  def rates_filename
    "#{RATES_DIRECTORY}/#{@base_currency}.yml"
  end

  def save_rates_in_local_file(rates)
    return unless rates
    File.open(rates_filename, 'w') { |file| YAML.dump(rates, file) }
  end
end
