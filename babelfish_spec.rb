#!/usr/bin/env ruby -w
# babelfish_spec.rb
# Description: Remove language boundaries

require 'whatlanguage'
require 'i18n'
require 'globalize'
require 'hstore_translate'
require 'http_accept_language'
require 'easy_translate'
require 'to_lang'

class BabelFish
end

## USAGE
# babelfish --set en de
  #=> Say 'Guten Tag!' (en|de)
# babelfish
  #=> listening...
  #<= Hola!
  #=> Say 'Hola amigo!' (en|es)
# babelfish Hola.
  #=> Say 'Hola amigo'. (en|es)
# babelfish --out 'Hola amigo.'
  #=> Hello friend.
# babelfish -i 'Oh Hector, so good to see you!'
  #=> Oh Hector, tan bueno verte!

if __FILE__ == $0
end
