def draw_helper_board
puts "********** Welcome to Ruby Tic Tac Toe! **********"
puts
puts "                    1 | 2 | 3 "
puts "                   ---+---+---"
puts "                    4 | 5 | 6 "
puts "                   ---+---+---"
puts "                    7 | 8 | 9 "
puts
end

def initialize_board
  board = {}
  (1..9).each {|position| board[position] = ' '}
  board
end
 
def empty_positions(board)
  board.keys.select {|position| board[position] == ' '}
end
 
def player_places_piece(board)
  begin
    puts "Enter a box number (1-9):"
    position = gets.chomp.to_i
  end until empty_positions(board).include?(position)
  board[position] = "X"
end
 
def computer_places_piece(board)
  puts "Computer's turn..."
  sleep(2)
  position = empty_positions(board).sample
  board[position] = "O"
end
 
def check_winner(board)
  @we_have_a_winner = false
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if board.values_at(*line).count("X") == 3
      @we_have_a_winner = true
      return "You"
    elsif board.values_at(*line).count("O") == 3
      @we_have_a_winner = true
      return "Computer"
    else
      @we_have_a_winner = false
    end
  end
end
 
def nine_positions_are_filled?(board)
  empty_positions(board) == []
end
 
def announce_winner(winner)
  puts "#{winner} won!"
end
 
def draw_board(board)
  system "clear"
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts "---+---+---"
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts "---+---+---"
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
end

draw_helper_board 
board = initialize_board
draw_board(board)
begin
  player_places_piece(board)
  draw_board(board)
  check_winner(board)
  computer_places_piece(board) unless @we_have_a_winner
  draw_board(board)
  check_winner(board)
end until @we_have_a_winner || nine_positions_are_filled?(board)
if check_winner(board)
  winner = check_winner(board)
  announce_winner(winner)
else
  puts "It's a tie!"
end
