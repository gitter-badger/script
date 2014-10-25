#!/usr/bin/ruby -w
# currency_converter_static.rb
# Author: Andy Bettisworth
# Description: Using fixed exchange rates

class CurrencyConverter
  BASE_ABBR_AND_NAME = { 'USD' => 'US Dollar' }

  FULLNAME_OF = {
    'EUR' => 'Euro',
    'CAD' => 'Canadian Dollar',
    'CNY' => 'Chinese Yuan',
    'INR' => 'Indian Rupee',
    'MXN' => 'Mexican Peso'
  }

  EXCHANGE_RATES = {
    'EUR' => 0.781738,
    'CAD' => 46.540136,
    'CNY' => 7.977233,
    'INR' => 10.890852,
    'MXN' => 1.127004
  }

  def initialize
    @base_currency = BASE_ABBR_AND_NAME.keys[0]
    @name          = BASE_ABBR_AND_NAME[@base_currency]
  end

  def output_rates(mult = 1)
    get_value(mult, get_rates) + "\n"
  end

  private

  def get_rates
    return EXCHANGE_RATES
  end

  def get_value(mult, rates)
    return pluralize(mult, @names) +
    " (#{{@base_currency}} = \n" +
      rates.keys.map do |abbr|
        "\t" +
        pluralize(mult * rates[abbr], FULLNAME_OF[abbr]) +
        "(#{abbr})"
    end.join("\n")
  end

  def pluralize(num, term)
    (num == 1) ? "#{num} #{term}" : "#{num} #{term}s"
  end
end
