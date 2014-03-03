#!/usr/bin/ruby -w
# canvas_whatlanguage.rb
# Description: Canvas whatlanguage gem

require 'whatlanguage'

## Convenience method on String
# "This is a test".language #=> "English"

## READ language of international text array
# texts = []
# texts << %q{Deux autres personnes ont été arrêtées durant la nuit}
# texts << %q{The links between the attempted car bombings in Glasgow and London are becoming clearer}
# texts << %q{En estado de máxima alertaen su nivel de crítico}
# texts << %q{Returns the object in enum with the maximum value.}
# texts << %q{Propose des données au sujet de la langue espagnole.}
# texts << %q{La palabra "mezquita" se usa en español para referirse a todo tipo de edificios dedicados.}
# texts << %q{اللغة التي هي هذه؟}
# texts << %q{Mitä kieltä tämä on?}
# texts << %q{Ποια γλώσσα είναι αυτή;}
# texts << %q{באיזו שפה זה?}
# texts << %q{Milyen nyelv ez?}
# texts << %q{이 어떤 언어인가?}
# texts << %q{Hvilket språk er dette?}
# texts << %q{W jakim języku to jest?}
# texts.each { |text| puts "#{text[0..18]}... is in #{text.language.to_s.capitalize}" }

# wl = WhatLanguage.new(:all)
## Return language with best score
# text = 'W jakim języku to jest?'
# puts wl.language(text)
  #=> polish

## Return hash with scores for all relevant languages
# wl = WhatLanguage.new(:all)
# text = '이 어떤 언어인가?'
# puts wl.process_text(text)
  #=> {:russian=>2, :french=>1, :korean=>2, :italian=>1, :spanish=>1}
# puts wl.language(text)
  #=> russian

## NOTE - the accuracy of this gem is dependent on quantity of text available
##  IDEA - babelfilsh, the rspec cmd-line app,
##    will need to build probalibity hashes
# wl = WhatLanguage.new(:all)
# text = 'Hola amigo.'
# puts 'text: ' + text
# puts wl.process_text(text)
# puts 'LANGUAGE: ' + text.language.to_s.upcase
#   #=> text: Hola amigo.
#   #=> {:english=>1, :polish=>1, :finnish=>1, :spanish=>1, :hungarian=>1, \
#   #=>   :portuguese=>1, :dutch=>1, :norwegian=>1}
#   #=> LANGUAGE: ENGLISH
# puts "\n"

# text = 'Hola amigo. ¿Qué vas a hacer hoy?'
# puts 'text: ' + text
# puts wl.process_text(text)
# puts 'LANGUAGE: ' + text.language.to_s.upcase
#   #=> text: Hola amigo. ¿Qué vas a hacer hoy?
#   #=> {:english=>3, :polish=>2, :finnish=>3, :spanish=>4, :hungarian=>3, \
#   #=>   :portuguese=>2, :dutch=>1, :norwegian=>3, :russian=>5, :french=>2, \
#   #=>   :swedish=>1, :arabic=>1, :hebrew=>1, :greek=>1, :korean=>1, :farsi=>1}
#   #=> LANGUAGE: RUSSIAN
# puts "\n"

# text = 'Hola amigo. ¿Qué vas a hacer hoy? Es un buen día ¿no?'
# puts 'text: ' + text
# puts wl.process_text(text)
# puts 'LANGUAGE: ' + text.language.to_s.upcase
#   #=> text: Hola amigo. ¿Qué vas a hacer hoy? Es un buen día ¿no?
#   #=> {:english=>5, :polish=>4, :finnish=>5, :spanish=>8, :hungarian=>5, \
#   #=>   :portuguese=>2, :dutch=>2, :norwegian=>6, :russian=>6, :french=>5, \
#   #=>   :swedish=>1, :arabic=>2, :hebrew=>1, :greek=>2, :korean=>1, :farsi=>1,
#   #=>   :german=>2, :italian=>3}
#   #=> LANGUAGE: SPANISH

## > Play with the main datatype used, Bloom Filters
## LINK: http://en.wikipedia.org/wiki/Bloom_filter

