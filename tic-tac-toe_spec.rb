class TicTacToe
  VALID_MOVE = [
    'top left', 'top center', 'top right',
    'mid left', 'mid center', 'mid right',
    'bot left', 'bot center', 'bot right'
  ]
  CENTER_MOVE = [4]
  CORNER_MOVE = [0, 2, 6, 8]
  OUTER_CENTER_MOVE = [1, 3, 5, 7]
  X_BOARD = [
    '    X   ', '    X     ', '    X    ',
    '    X   ', '    X     ', '    X    ',
    '    X   ', '    X     ', '    X    '
  ]
  O_BOARD = [
    '    O   ', '    O     ', '    O    ',
    '    O   ', '    O     ', '    O    ',
    '    O   ', '    O     ', '    O    '
  ]
  WIN = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  attr_accessor :board_state
  attr_accessor :valid_move
  attr_accessor :center_move
  attr_accessor :corner_move
  attr_accessor :outer_center_move
  attr_accessor :move_count
  attr_accessor :player_moves
  attr_accessor :ai_moves

  def start
    set_board
    puts new_game_instructions
    update_board(player_move)
    puts ''
    update_board(ai_countermove)
    puts board_state
    continue
  end

  private

  def set_board
    self.move_count = 0
    self.player_moves = []
    self.ai_moves = []
    self.board_state = Array.new(9)
    i = 0
    VALID_MOVE.each do
      @board_state[i] = VALID_MOVE[i]
      i += 1
    end
    self.valid_move = CENTER_MOVE.clone + CORNER_MOVE.clone + OUTER_CENTER_MOVE.clone
    self.center_move = CENTER_MOVE.clone
    self.corner_move = CORNER_MOVE.clone
    self.outer_center_move = OUTER_CENTER_MOVE.clone
  end

  def new_game_instructions
    <<-MESSAGE
          ###########################
          ### TicTacToe: New Game ###
          ###########################

#{board_state}

Q: What is your first move?
    MESSAGE
  end

  def board_state
    <<-BOARD
+--------------+----------------+---------------+
|   #{@board_state[0]}   |   #{@board_state[1]}   |   #{@board_state[2]}   |
+--------------+----------------+---------------+
|   #{@board_state[3]}   |   #{@board_state[4]}   |   #{@board_state[5]}   |
+--------------+----------------+---------------+
|   #{@board_state[6]}   |   #{@board_state[7]}   |   #{@board_state[8]}   |
+--------------+----------------+---------------+
    BOARD
  end

  def continue
    puts ''
    puts "Q: What is your next move?"
    update_board(player_move)
    puts ''
    update_board(ai_countermove)
    puts board_state
    continue
  end

  def player_move
    player_command = ''
    player_move  = 99
    possible_moves = @valid_move.map { |i| VALID_MOVE[i] }
    until VALID_MOVE.include?(player_command) && @valid_move.include?(player_move)
      player_command = gets.chomp
      warn %Q{
  Invalid move: "#{player_command}"
  Valid moves: "#{@valid_move.each { |i| puts "#{VALID_MOVE[i]}, " }}"
        } unless possible_moves.include?(player_command)
      player_move = VALID_MOVE.find_index(player_command)
    end
    @valid_move.delete(player_move)
    @center_move.delete(player_move)
    @corner_move.delete(player_move)
    @outer_center_move.delete(player_move)
    [X_BOARD, player_move]
  end

  def ai_countermove
    if @move_count == 1
      @player_moves[0] != 4 ? ai_move = 4 : ai_move = @corner_move.sample
    elsif @move_count == 2
      ai_move ||= @outer_center_move.sample
      # @ai_moves[0] == 4 ? ai_move = @outer_center_move.sample : ai_move = @corner_move.sample
    elsif @move_count == 3
      ai_move ||= @outer_center_move.sample
      ai_move ||= @corner_move.sample
    elsif @move_count == 4
      ai_move ||= @outer_center_move.sample
      ai_move ||= @corner_move.sample
    elsif @move_count == 5
      ai_move ||= @outer_center_move.sample
      ai_move ||= @corner_move.sample
    elsif @move_count == 6
      ai_move ||= @outer_center_move.sample
      ai_move ||= @corner_move.sample
    else
    end
    @valid_move.delete(ai_move)
    @center_move.delete(ai_move)
    @corner_move.delete(ai_move)
    @outer_center_move.delete(ai_move)
    [O_BOARD, ai_move]
  end

  def update_board(args)
    board = args[0]
    move = args[1]
    @board_state[move] = board[move]

    @player_moves = @board_state.each_index.select { |i| @board_state[i] =~ /X/ }
    @ai_moves = @board_state.each_index.select { |i| @board_state[i] =~ /O/ }
    @move_count = @player_moves.size

    if tic_tac_toe? || @valid_move.empty?
      end_game
      exit
    end
  end

  def tic_tac_toe?
    WIN.each do |win_combination|
      return true if (win_combination & @player_moves).size == 3
      return true if (win_combination & @ai_moves).size == 3
    end
    false
  end

  def end_game
    puts ''
    puts board_state
    WIN.each do |win_combination|
      if (win_combination & @player_moves).size == 3
        puts player_wins
        return
      end
      if (win_combination & @ai_moves).size == 3
        puts ai_wins
        return
      end
    end
    puts tie_game if @valid_move.empty?
  end

  def tie_game
    <<-MESSAGE

          ###########################
          ### TicTacToe: Tie Game ###
          ###########################

    MESSAGE
  end

  def player_wins
    <<-MESSAGE

      ###################################
      ### TicTacToe: Congratulations! ###
      ###################################

    MESSAGE
  end

  def ai_wins
    <<-MESSAGE

          ############################
          ### TicTacToe: Game Over ###
          ############################

    MESSAGE
  end
end

## Usage
game = TicTacToe.new
game.start

## CREATE an unbeatable Tic-Tac-Toe AI
##  As a programmer
##  I want an unbeatable Tic-Tac-Toe AI
##  So that I can pass the first test of 8th Light Apprenticeship
# describe TicTacToe do
#   before :each do
#     @game = TicTacToe.new
#   end

#   it "should ask for player's first move when a new game starts" do
#     @game.send(:set_board)
#     instructions = @game.send(:new_game_instructions)
#     expect(instructions).to eq(
#     <<-MESSAGE
#           ###########################
#           ### TicTacToe: New Game ###
#           ###########################

# +--------------+----------------+---------------+
# |   top left   |   top center   |   top right   |
# +--------------+----------------+---------------+
# |   mid left   |   mid center   |   mid right   |
# +--------------+----------------+---------------+
# |   bot left   |   bot center   |   bot right   |
# +--------------+----------------+---------------+

# Q: What is your first move?
#     MESSAGE
# )
#   end

#   it "should validate 'moves' by matching against allowable response set" do
#     @game.stub(:gets) { 'all the boxes please' }
#     lambda { @game.send(:player_move)}.should raise_error
#   end

#   it "should display updated board upon valid player move" do
#     @game.stub(:gets) { 'top left' }
#     @game.start
#     expect(@game.send(:board_state)).to eq(
#     <<-BOARD
# +--------------+----------------+---------------+
# |       X      |   top center   |   top right   |
# +--------------+----------------+---------------+
# |   mid left   |   mid center   |   mid right   |
# +--------------+----------------+---------------+
# |   bot left   |   bot center   |   bot right   |
# +--------------+----------------+---------------+
#     BOARD
# )
#   end

#   it "should loop 'player_move()' until board is filled" do
#     @game.stub(:gets) { 'top left' }
#     @game.start
#     @game.stub(:gets) { 'top center' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'top right' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'mid left' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'mid center' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'mid right' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'bot left' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'bot center' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'bot right' }
#     @game.send(:continue)
#     @game.stub(:gets) { 'bot right' }
#     expect(@game.send(:continue)).to raise_error
#   end

#   it "should have AI make a counter move", wip: true do
#     @game.stub(:gets) { 'top left' }
#     @game.start
#     @game.stub(:gets) { 'bot right' }
#     @game.send(:continue)
#     @game.send(:ai_countermove)
# #     expect(@game.send(:board_state)).to eq(
# #     <<-BOARD
# # +--------------+----------------+---------------+
# # |       X      |   top center   |   top right   |
# # +--------------+----------------+---------------+
# # |       O      |       O        |   mid right   |
# # +--------------+----------------+---------------+
# # |   bot left   |   bot center   |       X       |
# # +--------------+----------------+---------------+
# #     BOARD
# # )
#   end
# end
