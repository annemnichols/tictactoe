
$grid_hash = Hash["tl" => " ", "tc" => " ", "tr" => " ", 
							"cl" =>  " ", "cc" =>  " ", "cr" =>  " ",
							"bl" =>  " ", "bc" =>  " ", "br" =>  " "]

$player_piece = ''
$computer_piece = ''

def show_grid
	puts "\n #{$grid_hash["tl"]} | #{$grid_hash["tc"]} | #{$grid_hash["tr"]}"
	puts "-----------"
	puts " #{$grid_hash["cl"]} | #{$grid_hash["cc"]} | #{$grid_hash["cr"]}"
	puts "-----------"
	puts " #{$grid_hash["bl"]} | #{$grid_hash["bc"]} | #{$grid_hash["br"]}"
end

def greeting
	system "clear"
	puts ""
	puts "___  _  ___   ___  _  ___   ___ ___ ___"
	puts " |   |  |   _  |  /_\\ |   _  |  | | |__"
	puts " |   |  |__    |  | | |__    |  |_| |__"
	puts ""
end

def choose_piece
	greeting
	puts "Would you like to be X or O?"
	print "> "
	$player_piece = gets.chomp.upcase
	if $player_piece == "O" || $player_piece == "X"
		if $player_piece == "X"
			$computer_piece = "O"
		else
			$computer_piece = "X"
		end
		play
	else
		puts "That is not a valid entry."
		greeting
	end
end

# Player's turn

def play
	greeting
	puts "It's your turn! You are the " + $player_piece + " piece."
	show_grid
  
  puts " "
	puts "Choose a square to place your piece!"
	puts "Commands: TL = Top Left,    TC = Top Center,    TR = Top Right"
	puts "	  CL = Center Left, CC = Center Center, CR = Center Right"
	puts "	  BL = Bottom Left, BC = Bottom Center, BR = Bottom Right"
  print "> "

  $position = gets.chomp.downcase
  validate_user_position($position)
  place_piece($player_piece)
  check_for_win($player_piece)
  comp_turn
end

# Computer's turn

def comp_turn
	choice_array = ["tl", "tc", "tr", "cl", "cc", "cr", "bl", "bc", "br"]
	computer_choice = choice_array.sample

  validate_computer_position(computer_choice)
	place_piece($computer_piece)
	puts "The computer took it's turn!"
	check_for_win($computer_piece)
	play
end

# Make sure space user chooses is empty

def validate_user_position(position)
  if $grid_hash[position] == ' '
  	$confirmed_piece = position
    return true
  elsif $grid_hash[position] == nil
  	puts "That is not a valid entry."
  	play
  else
    puts "That spot is already taken."
    play
  end
end

# Make sure space computer chooses is empty

def validate_computer_position(position)
  if $grid_hash[position] == ' '
  	$confirmed_piece = position
    return true
  else
    comp_turn
  end
end

# Places piece on the board

def place_piece(player)
  $grid_hash[$confirmed_piece] = player
  return true
end

# Checks to see if anyone has won 

def check_for_win(player)
	if ($grid_hash["tl"] == player) && ($grid_hash["tc"] == player) && ($grid_hash["tr"] == player)
		win(player)
	elsif ($grid_hash["cl"] == player) && ($grid_hash["cc"] == player) && ($grid_hash["cr"] == player)
		win(player)
	elsif ($grid_hash["bl"] == player) && ($grid_hash["bc"] == player) && ($grid_hash["br"] == player)
		win(player)
	elsif ($grid_hash["tl"] == player) && ($grid_hash["cl"] == player) && ($grid_hash["bl"] == player)
		win(player)
	elsif ($grid_hash["tc"] == player) && ($grid_hash["cc"] == player) && ($grid_hash["bc"] == player)
		win(player)
	elsif ($grid_hash["tr"] == player) && ($grid_hash["cr"] == player) && ($grid_hash["br"] == player)
		win(player)
	elsif ($grid_hash["tl"] == player) && ($grid_hash["cc"] == player) && ($grid_hash["br"] == player)
		win(player)
	elsif ($grid_hash["bl"] == player) && ($grid_hash["cc"] == player) && ($grid_hash["tr"] == player)
		win(player)
	else
		check_for_tie
	end
end

# Code to perform if someone has won

def win(player)
	greeting
  puts "---------------------"
  show_grid
  puts ""
  puts "G A M E   O V E R"
  puts ""
	if player == $computer_piece
		puts "The computer wins!"
	else
		puts "You won the game!"
	end
	puts ""
	puts "---------------------"
	exit
end

# Checks to see if there is a tied game

def check_for_tie
	if $grid_hash.has_value?(" ")
		return true
	else
		tie 
	end
	exit
end

# Code to perform if there is a tie

def tie
	greeting
  puts "---------------------"
  show_grid
  puts ""
  puts "G A M E   O V E R"
  puts ""
	puts "Tied game!"
	puts ""
	puts "---------------------"
end

choose_piece