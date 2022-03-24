# frozen_string_literal:true

require './player.rb'
require './display_and_board.rb'

#class for the tic tac toe game
class Game 
  attr_reader :game_display, :player1, :player2
  def initialize()
    @game_display=DisplayAndBoard.new()
    create_players
  end

  def create_players
    @player1 = create_one_player(1)
    @player2 = create_one_player(2)
    check_player_symbols
  end

  def check_player_symbols
    while @player2.symbol == @player1.symbol
      puts "That symbol is already taken, please choose a different one."
      symbol = gets.chomp
      @player2.symbol = check_symbol_length(symbol)
    end
  end

  def check_symbol_length(symbol)
    until symbol.length == 1 do 
      puts "That's not a valid symbol, please choose something that has the length of one"
      symbol = gets.chomp
    end
    symbol
  end

  def create_one_player(i)
    puts "Enter name for Player #{i}:"
    name = gets.chomp
    puts "Enter symbol for Player #{i}:"
    symbol = gets.chomp
    check_symbol_length(symbol)
    Player.new(name,symbol)    
  end

  def translate_location(number)
    if number >= 1 && number <=3
      [0,number-1]
    elsif number >=4 && number <= 6
      [1,number-4]
    elsif number >=7 && number <= 9
      [2,number-7]
    end
  end 

  def choose_location(player)
    player_symbol = player.symbol
    puts "Pick a location #{player.name}"
    temporary_location = gets.chomp.to_i
    location = translate_location(temporary_location)
    if @game_display.check_if_free(location[0],location[1])
      @game_display.change_board(location[0],location[1],player_symbol)
    else
      puts "That space is already taken, please pick another one!"
      choose_location(player)
    end 
  end

  def play_turn(player)
    choose_location(player)
    puts @game_display.current_display
    puts "Player #{player.name} won! Congratulations" if @game_display.check_win(player.symbol)
  end

  def new_game?
    puts "Do you want to play another game? If so, type Yes"
    answer = gets.chomp.downcase
    puts "NEW GAME" if answer == 'yes'
    answer == 'yes'
  end

  def play_game 
    puts @game_display.current_display
    until @game_display.check_draw || @game_display.check_win(@player1.symbol) || @game_display.check_win(player2.symbol)
      play_turn(@player1)
      break if @game_display.check_win(@player1.symbol)
      if @game_display.check_draw()
        puts "It's a DRAW!"
        break
      end 
      play_turn(@player2)
    end
  end
end