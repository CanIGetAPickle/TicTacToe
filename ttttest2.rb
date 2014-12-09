require 'pry'

class Board
  attr_accessor :boxes, :winning_combinations
  
  def initialize
    @boxes = { 
        1 => " ", 
        2 => " ", 
        3 => " ", 
        4 => " ", 
        5 => " ", 
        6 => " ", 
        7 => " ", 
        8 => " ", 
        9 => " " 
      }
    @winning_combinations = [
        [boxes[1], boxes[2], boxes[3]], 
        [boxes[4], boxes[5], boxes[6]], 
        [boxes[7], boxes[8], boxes[9]], 
        [boxes[1], boxes[4], boxes[7]], 
        [boxes[2], boxes[5], boxes[8]], 
        [boxes[3], boxes[6], boxes[9]], 
        [boxes[1], boxes[5], boxes[9]], 
        [boxes[3], boxes[5], boxes[7]]
      ] 
  end
  
  def introduce
    puts "********** Welcome to Ruby Tic Tac Toe! **********"
    puts
    puts "                    1 | 2 | 3 "
    puts "                   ---+---+---"
    puts "                    4 | 5 | 6 "
    puts "                   ---+---+---"
    puts "                    7 | 8 | 9 "
    puts
  end

  def draw
    puts " #{boxes[1]} | #{boxes[2]} | #{boxes[3]} "
    puts "---+---+---"
    puts " #{boxes[4]} | #{boxes[5]} | #{boxes[6]} "
    puts "---+---+---"
    puts " #{boxes[7]} | #{boxes[8]} | #{boxes[9]} "
  end

  def all_positions_filled?
    boxes.all? { |key, value| value != " " }
  end
end

class Human

  def choose(board)
    puts ">>> Your turn. Enter a box number:"
    choice = gets.chomp.to_i
    if board.boxes[choice] != " "
      puts ">>> Illegal move! Try again."
      choose(board)
    else
      board.boxes[choice] = "X"
    end      
  end

end

class Computer

  def steal_win(board)
    i = 0
    line = board.winning_combinations[i]
    until line.one? { |value| value == " " }
      i += 1
    end
    if line.values_at(0, 1) == ["X", "X"] || line.values_at(0, 1) == ["O", "O"]
      line[2] = "O"
    elsif line.values_at(0, 2) == ["X", "X"] || line.values_at(0, 2) == ["O", "O"]
      line[1] = "O"
    else
      line[0] = "O"
    end
  end

  def random_pick(board)
    random = board.boxes.keys.sample until board.boxes[random] == " "
    board.boxes[random] = "O"
  end

  def can_steal?(board)
    binding.pry
    board.winning_combinations.any? { |line| line.sort == [" ", "X", "X"] || line.sort == [" ", "O", "O"] }
  end

  def choose(board)
    puts ">>> Computer's turn..."
    sleep(1)
    if can_steal?(board)
      steal_win(board)
    else
      random_pick(board)
    end
  end
end

class Game
  attr_reader :player, :computer, :board

  def initialize
    @player = Human.new
    @computer = Computer.new
    @board = Board.new
  end
  
  def winner?
    board.winning_combinations.any? { |line| line == ["X", "X", "X"] || line == ["O", "O", "O"] }
  end
  
  def tie?
    board.all_positions_filled? && winner? == false
  end
  
  def player_turn
    unless board.all_positions_filled? || winner?
      player.choose(board)
      board.draw
    end
  end
  
  def computer_turn
    unless board.all_positions_filled? || winner?
      computer.choose(board)
      board.draw
    end
  end
  
  def play
    board.introduce
    begin
      player_turn
      computer_turn
    end until winner? || tie?
    if tie?
      puts "It's a tie!"
    else
      puts "Game Over!"
    end
  end
end

game = Game.new.play