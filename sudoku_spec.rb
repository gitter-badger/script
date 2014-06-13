class Sudoku

  attr_accessor :board

  def generate_board
    self.board = Array.new(9) { Array.new(3) {Array.new(3) } }
    9.times do |x|
      3.times do |y|
        3.times do |z|
          @board[x][y][z] = Random.rand(1..9)
        end
      end
    end
  end
end

describe Sudoku do

  before(:each) do
    @game = Sudoku.new
  end

  describe "#generate_board" do
    it "should create a 9x3x3 arrays" do
      @game.generate_board
      expect(@game.board).to be_a(Array)
      expect(@game.board).to have(9).things
      expect(@game.board[0]).to have(3).things
      expect(@game.board[0][0]).to have(3).things
    end

    it "should have random numbers from 1 to 9 for each element" do
      @game.generate_board
      9.times do |x|
        3.times do |y|
          3.times do |z|
            expect(@game.board[x][y][z]).to be_an(Integer)
            expect(@game.board[x][y][z] >= 1).to be_true
            expect(@game.board[x][y][z] <= 9).to be_true
          end
        end
      end
    end
  end
end
