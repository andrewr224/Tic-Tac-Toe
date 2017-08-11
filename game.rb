# the Game class; one starts and plays the game here
# contains info about turns and keeps the score
class Game
  # a score class variable contains score
  @@score = {draws: 0}

  attr_reader :x, :o
  def initialize
    @board = Board.new
    @x = Player.new("X")
    @o = Player.new("O")
    @@score["Player #{@x.mark}"] ||= 0
    @@score["Player #{@o.mark}"] ||= 0
    @current_player = @x
    @other_player = @o
    @turns = 0
    play
  end

  private
  # the game automatically starts here
  def play
    # unless the game is over players take turns
    take_turn until game_over?

    #start a new game if the game is over
    new_game_or_quit
  end

  def new_game_or_quit
    puts "Wanna play more? [Y/N]"
    reply = gets.chomp.downcase[0]
    if reply == "y"
      Game.new
    elsif reply == "n"
      puts "I hope you had a good game. Bye!"
      exit
    else
      puts "Sorry, can't understand you. Bye!"
      exit
    end
  end

  # players take turns and enter the number of a box they want to take
  def take_turn
    @board.show_board
    puts "#{@current_player}'s turn."
    square = 0
    until ((1..9) === square) && @board.take_a_square(square, @current_player)
      puts "Which square do you want to take?"
      square = gets.to_i
    end
    @current_player.occupy_a_square(square)
    @current_player, @other_player = @other_player, @current_player
    @turns += 1
  end

  # check if the game is over
  def game_over?
    if victory?
      @@score["Player #{@other_player.mark}"] += 1
      puts "\nBehold the winner - the #{@other_player}!!!\n"
      # show_score
      show_score
      true
    elsif @turns == 9
      @@score[:draws] += 1
      puts "\nIt's a draw!\n"
      # show_score
      show_score
      true
    else
      false
    end
  end

  # checks if anyone won
  def victory?
    won = false
    @board.winning_combos.each do |combo|
      won = true if (combo & @other_player.squares) == combo
    end
    won
  end

  # display the score hash in an orderly fashion
  def show_score
    puts
    @@score.each do |player, score|
      print "- #{player.capitalize}: #{score} -"
    end
    puts
  end

  # the Player class contains the info about boxes checked by the player
  class Player
    attr_reader :mark, :squares

    def initialize(mark)
      @mark = mark
      @squares = []
    end

    def occupy_a_square(square)
      @squares << square
    end

    def to_s
      "Player #{@mark}"
    end
  end

  # the Board class contains info about the situation on the board
  class Board
    # the_board array contains the initial board
    @@the_board = [7,8,9,4,5,6,1,2,3]
    @@winning_combos = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    # creates an enmpty board
    def initialize
      @board = @@the_board.clone
    end

    # the method that shows a board
    def show_board
      puts
      @board.each_with_index do |square, i|
        print " #{square} "
        puts "\n\n" if (i == 2 || i == 5 || i == 8)
      end
    end

    def winning_combos
      @@winning_combos
    end

    # the method for taking a square
    def take_a_square(square, player)
      i = free_to_take?(square)
      @board[i] = player.mark if i
    end

    private
    # checks if the square is unnocupied (and forwards the call)
    def free_to_take?(square)
      i = @@the_board.index(square)
      @@the_board
      @board[i] == @@the_board[i] && i
    end
  end
end

game = Game.new
