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
        [1, 2, 3], 
        [4, 5, 6], 
        [7, 8, 9], 
        [1, 4, 7], 
        [2, 5, 8], 
        [3, 6, 9], 
        [1, 5, 9], 
        [3, 5, 7]
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

  def random_pick(board)
    random = board.boxes.keys.sample until board.boxes[random] == " "
    board.boxes[random] = "O"
  end

  def choose(board)
    puts ">>> Computer's turn..."
    sleep(1)
    random_pick(board)
  end
end

class Game
  attr_reader :player, :computer, :board

  def initialize
    @player = Human.new
    @computer = Computer.new
    @board = Board.new
  end
  
  def check_for_winner
    board.winning_combinations.each do |line|
      if (board.boxes[line[0]] == "X" && board.boxes[line[1]] == "X" && board.boxes[line[2]] == "X") 
        return "human"
      elsif (board.boxes[line[0]] == "O" && board.boxes[line[1]] == "O" && board.boxes[line[2]] == "O")
        return "computer"
      else
        nil
      end
    end
    nil
  end 
  
  def tie?
    board.all_positions_filled? && check_for_winner == nil
  end
  
  def player_turn
    unless board.all_positions_filled? || check_for_winner
      player.choose(board)
      board.draw
    end
  end
  
  def computer_turn
    unless board.all_positions_filled? || check_for_winner
      computer.choose(board)
      board.draw
    end
  end

  def game_over
    print "\a"
    puts ">>> Game over!"
  end
  
  def play
    board.introduce
    begin
      player_turn
      computer_turn
    end until check_for_winner || tie?
    if check_for_winner == "computer"
      puts ">>> Sorry - you lost!"
      game_over
    elsif check_for_winner == "human"
      puts ">>> Congratulations - you won!"
      game_over
    else
      puts ">>> It's a tie!"
      game_over
    end
  end
end

game = Game.new.play