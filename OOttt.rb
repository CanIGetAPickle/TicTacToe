class Board
  attr_accessor :boxes
  attr_reader :winning_combinations
  
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
    if boxes.values.all? { |values| values != " " }
      puts "It's a tie!"
    else
      return false
    end      
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

  def steal_win?(board)
    board.winning_combinations.each do |line|
      if line.one? { |value| value == " " }
        value = "O"
      else
        return false
      end
    end
  end

  def random_pick(board)
    
    random = board.boxes.keys.sample until board.boxes[random] == " "
    board.boxes[random] = "O"
  end

  def choose(board)
    puts ">>> Computer's turn..."
    sleep(1)
    random_pick(board) unless steal_win?(board)
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
    board.winning_combinations.any? { |*line| line == "X" || line == "O" }
  end  
  
  def play
    board.introduce
    begin
      player.choose(board)
      board.draw
      computer.choose(board)
      board.draw
    end until winner? || board.all_positions_filled?
  end
end

game = Game.new.play