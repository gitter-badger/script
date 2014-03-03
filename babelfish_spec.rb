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

describe BabelFish do
  describe "#set" do
    it "should set in: and out: for babelfish"
    it "should filter only the first 2 arguments"
    it "should validate language codes"
  end

  describe "#detect" do
    it "should detect language code of input"
    it "should translate all subsequent input after detection"
  end

  describe "#in" do
    it "should set the language input"
  end

  describe "#out" do
    it "should set the language output"
  end
end
