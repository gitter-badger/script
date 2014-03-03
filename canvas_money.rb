#!/usr/local/ruby -w
# canvas_money.rb
# Author: Andy Bettisworth
# Description: Canvas Money gem

#############
### USAGE ###
# require 'money'
# ## 10.00 USD
# money = Money.new(1000, "USD")
# money.cents     #=> 1000
# money.currency  #=> Currency.new("USD")

# ## Comparisons
# Money.new(1000, "USD") == Money.new(1000, "USD")   #=> true
# Money.new(1000, "USD") == Money.new(100, "USD")    #=> false
# Money.new(1000, "USD") == Money.new(1000, "EUR")   #=> false
# Money.new(1000, "USD") != Money.new(1000, "EUR")   #=> true

# ## Arithmetic
# Money.new(1000, "USD") + Money.new(500, "USD") == Money.new(1500, "USD")
# Money.new(1000, "USD") - Money.new(200, "USD") == Money.new(800, "USD")
# Money.new(1000, "USD") / 5                     == Money.new(200, "USD")
# Money.new(1000, "USD") * 5                     == Money.new(5000, "USD")

# ## Currency conversions
# #some_code_to_setup_exchange_rates
# Money.new(1000, "USD").exchange_to("EUR") == Money.new(some_value, "EUR")
### USAGE ###
#############
