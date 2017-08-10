# the Game class; one starts and plays the game here
# contains info about turns and keeps the score
class Game
  # a score class variable contains score
  @@score = {x: 0, y: 0, draws: 0}
  def initialize
    @board = Board.new
    @x = Player.new("X")
    @o = Player.new("O")
  end

  # private

  # the game automatically starts here
  def play
    # unless the game is over players take turns
    game_over || take_turn
  end

  # players take turns and enter the number of a box they want to take
  def take_turn
  end

  # check if the game is over
  def game_over

  end
  # display the score hash in an orderly fashion
  def show_score

  end
end

# the Player class contains the info about boxes checked by the player
class Player
  attr_reader :mark, squares:

  def initialize(mark)
    @mark = mark
    @squares = []
  end

  # private

  def occupy_a_square(square)
    @squares << square
  end
end

# the Board class contains info about the situation on the board
class Board
  # the_board array contains the initial board
  @@the_board = [7,8,9,4,5,6,1,2,3]
  @@winning_combos = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  # creates an enmpty board
  def initialize
    @board = @@the_board
  end

  # private

  # the method that shows a board
  def show_board
    @board.each_with_index do |square, i|
      print " #{square} "
      puts "\n\n" if (i == 2 || i == 5 || i == 8)
    end
  end

  # the method for taking a square
  def take_square

  end

  # checks if the square is unnocupied
  def unoccupied?

  end

  # checks if the game has ended
  def game_ended?

  end

  # finds the winner, or tells it's a draw
  def victory
  end
end

# the Computer class contains computers behaviour as an opponent (will be available later)
