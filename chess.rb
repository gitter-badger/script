#!/usr/bin/env ruby -w
# chess.rb
# Author: Andy Bettisworth
# Description: Play a game of chess at the command-line

## PGN Portable Game Notation

# format for recording chess games in plain text
# https://chessprogramming.wikispaces.com/

# [Event "Tilburg"]
# [Site "Tilburg"]
# [Date "1985.??.??"]
# [Round "8"]
# [White "Viktor Korchnoi"]
# [Black "Anthony Miles"]
# [Result "0-1"]
# [ECO "A30"]
# [WhiteElo "2630"]
# [BlackElo "2570"]
# [Annotator "Soltis, Andy"]
# [PlyCount "70"]
# [EventDate "1985.??.??"]

# 1. Nf3 Nf6 2. c4 b6 3. g3 c5 4. Bg2 Bb7 5. O-O g6 6. e3 Bg7 7. d4 cxd4 8. exd4
# Qc8 9. Na3 d5 10. Re1 dxc4 11. Qa4+ Nbd7 12. Qxc4 a6 13. Qe2 O-O 14. Bg5 Bd5
# 15. Qxe7 Re8 16. Qb4 Qb7 17. Nh4 Bf8 18. Qa4 Ne4 19. Bf4 Rac8 20. Rac1 b5 21.
# Qd1 Ndf6 22. f3 Nd6 23. b3 Nh5 24. Bd2 Be7 25. Rxc8 Rxc8 26. Nc2 Bxh4 27. gxh4
# Nf5 28. Nb4 Nxh4 29. Nxd5 Qxd5 30. Bh6 Nxg2 31. Kxg2 Ng7 32. Re5 Qd6 33. Re4
# Nf5 {Diagram [#]} 34. Bf4 Qxf4 35. Rxf4 Ne3+ 0-1

## Github Leapfrog

# https://github.com/capicue/pgn/tree/master/lib/pgn
# https://github.com/chicagogrooves/chess_on_rails
# https://github.com/pioz/chess/tree/master/lib/chess

## TODO
# > represent the board 8x8 64 square array
# > map actions to commands
# > initialize play loop

class PGNParser
  def parse(files)
    f = Passant::PGN::File.new(ARGV.first)

    puts "Parsing PGN with #{f.games.size} games.."

    f.games.each do |g|
      puts "Parsing #{g.title}.."
      g.to_board
    end

    puts "Done."
  end
end

class ChessBoard
    START = [
      ["R", "P", nil, nil, nil, nil, "p", "r"],
      ["N", "P", nil, nil, nil, nil, "p", "n"],
      ["B", "P", nil, nil, nil, nil, "p", "b"],
      ["Q", "P", nil, nil, nil, nil, "p", "q"],
      ["K", "P", nil, nil, nil, nil, "p", "k"],
      ["B", "P", nil, nil, nil, nil, "p", "b"],
      ["N", "P", nil, nil, nil, nil, "p", "n"],
      ["R", "P", nil, nil, nil, nil, "p", "r"],
    ]

    def initialize
      return START
    end
end

class ChessGame
  def play
    board = ChessBoard.new
    board.each do |row|
      puts row.inspect
    end
  end
end

if __FILE__ == $0
  game = ChessGame.new
  game.play
end
