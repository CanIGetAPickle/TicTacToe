def introduce_game_board
puts " 1 | 2 | 3 "
puts "---+---+---"
puts " 4 | 5 | 6 "
puts "---+---+---"
puts " 7 | 8 | 9 "
end

@game_board_boxes = { :box1 => " ", :box2 => " ", :box3 => " ", :box4 => " ", :box5 => " ", :box6 => " ", :box7 => " ", :box8 => " ", :box9 => " " }

def game_board
  puts " #{@game_board_boxes[:box1]} | #{@game_board_boxes[:box2]} | #{@game_board_boxes[:box3]} "
  puts "---+---+---"
  puts " #{@game_board_boxes[:box4]} | #{@game_board_boxes[:box5]} | #{@game_board_boxes[:box6]} "
  puts "---+---+---"
  puts " #{@game_board_boxes[:box7]} | #{@game_board_boxes[:box8]} | #{@game_board_boxes[:box9]} "
end

def play_again_message
  puts "::: Play again? (Y/N) :::"
  play_again = gets.chomp.upcase
  case play_again 
  when "Y"
    @game_board_boxes = { :box1 => " ", :box2 => " ", :box3 => " ", :box4 => " ", :box5 => " ", :box6 => " ", :box7 => " ", :box8 => " ", :box9 => " " }
    game_play
  else
    puts "Thanks for playing --- bye!"
  end
end

def winning_combinations
  @check_for_winner = false
  if ( @game_board_boxes[:box1] == "X" && @game_board_boxes[:box2] == "X" && @game_board_boxes[:box3] == "X") || (@game_board_boxes[:box4] == "X" && @game_board_boxes[:box5] == "X" && @game_board_boxes[:box6] == "X") || (@game_board_boxes[:box7] == "X" && @game_board_boxes[:box8] == "X" && @game_board_boxes[:box9] == "X") || (@game_board_boxes[:box1] == "X" && @game_board_boxes[:box4] == "X" && @game_board_boxes[:box7] == "X") || (@game_board_boxes[:box2] == "X" && @game_board_boxes[:box5] == "X" && @game_board_boxes[:box8] == "X") || (@game_board_boxes[:box3] == "X" && @game_board_boxes[:box6] == "X" && @game_board_boxes[:box9] == "X") || (@game_board_boxes[:box1] == "X" && @game_board_boxes[:box5] == "X" && @game_board_boxes[:box9] == "X") || (@game_board_boxes[:box3] == "X" && @game_board_boxes[:box5] == "X" && @game_board_boxes[:box7] == "X" )
    @check_for_winner = true
    puts "You win!"
    play_again_message
  elsif ( @game_board_boxes[:box1] == "O" && @game_board_boxes[:box2] == "O" && @game_board_boxes[:box3] == "O") || (@game_board_boxes[:box4] == "O" && @game_board_boxes[:box5] == "O" && @game_board_boxes[:box6] == "O") || (@game_board_boxes[:box7] == "O" && @game_board_boxes[:box8] == "O" && @game_board_boxes[:box9] == "O") || (@game_board_boxes[:box1] == "O" && @game_board_boxes[:box4] == "O" && @game_board_boxes[:box7] == "O") || (@game_board_boxes[:box2] == "O" && @game_board_boxes[:box5] == "O" && @game_board_boxes[:box8] == "O") || (@game_board_boxes[:box3] == "O" && @game_board_boxes[:box6] == "O" && @game_board_boxes[:box9] == "O") || (@game_board_boxes[:box1] == "O" && @game_board_boxes[:box5] == "O" && @game_board_boxes[:box9] == "O") || (@game_board_boxes[:box3] == "O" && @game_board_boxes[:box5] == "O" && @game_board_boxes[:box7] == "O" )
    @check_for_winner = true
    puts "Computer wins!"
    play_again_message
  elsif ( @game_board_boxes[:box1] != " " && @game_board_boxes[:box2] != " " && @game_board_boxes[:box3] != " " && @game_board_boxes[:box4] != " " && @game_board_boxes[:box5] != " " && @game_board_boxes[:box6] != " " && @game_board_boxes[:box7] != " " && @game_board_boxes[:box8] != " " && @game_board_boxes[:box9] != " " )
    @check_for_winner = true
    puts "It's a tie!"
    play_again_message
  else
    @check_for_winner = false
  end
end

def computer_choice
  box_keys = @game_board_boxes.keys;
  random_box = rand(box_keys.length)
  if @game_board_boxes[box_keys[random_box]] == " "
    return box_keys[random_box]
  else
    #first available empty slot
    @game_board_boxes.each { |box_key,box_value| return box_key if box_value == " " }
  end
end

def computer_move
  puts ">>> Computer's turn..."
  sleep(2)
  move = computer_choice
  @game_board_boxes[move] = "O"
end

def user_move
  puts ">>> Enter a box number:"
  move = gets.chomp
  case move
    when "1"
    invalid_user_input if @game_board_boxes[:box1] == "O"
    @game_board_boxes[:box1] = "X" unless @game_board_boxes[:box1] == "O"
    when "2"
    invalid_user_input if @game_board_boxes[:box2] == "O"
    @game_board_boxes[:box2] = "X" unless @game_board_boxes[:box2] == "O"
    when "3"
    invalid_user_input if @game_board_boxes[:box3] == "O"
    @game_board_boxes[:box3] = "X" unless @game_board_boxes[:box3] == "O"
    when "4"
    invalid_user_input if @game_board_boxes[:box4] == "O"
    @game_board_boxes[:box4] = "X" unless @game_board_boxes[:box4] == "O"
    when "5"
    invalid_user_input if @game_board_boxes[:box5] == "O"
    @game_board_boxes[:box5] = "X" unless @game_board_boxes[:box5] == "O"
    when "6"
    invalid_user_input if @game_board_boxes[:box6] == "O"
    @game_board_boxes[:box6] = "X" unless @game_board_boxes[:box6] == "O"
    when "7"
    invalid_user_input if @game_board_boxes[:box7] == "O"
    @game_board_boxes[:box7] = "X" unless @game_board_boxes[:box7] == "O"
    when "8"
    invalid_user_input if @game_board_boxes[:box8] == "O"
    @game_board_boxes[:box8] = "X" unless @game_board_boxes[:box8] == "O"
    when "9"
    invalid_user_input if @game_board_boxes[:box9] == "O"
    @game_board_boxes[:box9] = "X" unless @game_board_boxes[:box9] == "O"
  else
    invalid_user_input
  end
end

def invalid_user_input
  puts ">>> Illegal move! Try again."
  user_move
end

def game_play
  introduce_game_board
  begin
    user_move
    puts game_board
    winning_combinations
    computer_move
    puts game_board
    winning_combinations
  end until @check_for_winner
end

game_play
