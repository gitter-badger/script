#!/usr/bin/env ruby -w
# pgn_parser.rb
# Author: Andy Bettisworth
# Description: Parse Chess PGN Files (Portable Game Notation)

# input = '1. Nf3 Nf6 2. c4 b6 3. g3 c5 4. Bg2 Bb7 5. O-O g6 6. e3 Bg7 7. d4 cxd4 8. exd4'
# moves = input.split(/\d*\./)
# moves.collect! { |m| m.strip }
# moves.reject! { |m| m.empty? }
# puts moves.inspect
#=> ["Nf3 Nf6", "c4 b6", "g3 c5", "Bg2 Bb7", "O-O g6", "e3 Bg7", "d4 cxd4", "exd4"]

# > default Hashe[event] => Array[moves]
# > custom YAML representation

event = <<-STR
[Event "Tilburg"]
[Site "Tilburg"]
[Date "1985.??.??"]
[Round "8"]
[White "Viktor Korchnoi"]
[Black "Anthony Miles"]
[Result "0-1"]
[ECO "A30"]
[WhiteElo "2630"]
[BlackElo "2570"]
[Annotator "Soltis, Andy"]
[PlyCount "70"]
[EventDate "1985.??.??"]
STR
puts event

# class PGNParser
#   data = File.open(filename, 'r').read
# end

# if __FILE__ == $0
#   require 'optparse'

#   options = {}
#   option_parser = OptParse.new do |opts|
#     # > usage
#     opts.on('--yaml', 'Return in YAML format') do
#       options[:yaml] = true
#     end
#   end.parse!

#   parser = PGNParser.new

#   if options[:yaml]
#     puts 'YAML GOES HERE'
#     exit
#   end
#   puts option_parser
# end
