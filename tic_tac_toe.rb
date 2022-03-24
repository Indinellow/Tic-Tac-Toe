class DisplayAndBoard
  attr_reader :current_display, :board

  def initialize()
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @current_display= "\n ----------- \n| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} | \n ----------- \n| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} | \n ------------ \n| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |\n ----------- \n "
  end

  def check_if_free(row, column)
    if @board[row][column].instance_of? Integer
      true
    else
      false
    end
  end

  def change_board(row,column,symbol)
    @board[row][column]=symbol
    update_display()
  end 

  def update_display()
    @current_display= "\n ----------- \n| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} | \n ----------- \n| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} | \n ------------ \n| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |\n ----------- \n "
  end

  def check_win_row(symbol)
    @board[0].all? {|element| element==symbol} || @board[1].all? {|element| element==symbol} || @board[0].all? {|element| element==symbol}
  end

  def check_win_column(symbol)
    column_boolean_1 = (@board[0][0]==symbol && @board[1][0]==symbol && @board[2][0]==symbol)
    column_boolean_2 = (@board[0][1]==symbol && @board[1][1]==symbol && @board[2][1]==symbol)
    column_boolean_3 = (@board[0][2]==symbol && @board[1][2]==symbol && @board[2][2]==symbol)

    column_boolean_1 || column_boolean_2 || column_boolean_3
  end

  def check_win_diagonal(symbol)
    diagonal_boolean_1 = (@board[0][0]==symbol && @board[1][1]==symbol && @board[2][2]==symbol)
    diagonal_boolean_2 = (@board[0][2]==symbol && @board[1][1]==symbol && @board[2][0]==symbol)
    diagonal_boolean_1 || diagonal_boolean_2
  end

  def check_win(symbol)
    check_win_row(symbol) || check_win_column(symbol) || check_win_diagonal(symbol)
  end

  def check_draw()
  board[0].none? {|element| element.instance_of? Integer} && board[1].none? {|element| element.instance_of? Integer} && board[2].none? {|element| element.instance_of? Integer}
  end
end

class Player
  attr_accessor :name, :symbol
  def initialize(name,symbol)
    @name=name
    @symbol=symbol
  end
end 

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
    answer=gets.chomp.downcase
    puts "NEW GAME" if answer == 'yes'
    answer == 'yes'
  end

  def play_game 
    puts @game_display.current_display
    until @game_display.check_draw || @game_display.check_win(@player1.symbol) || @game_display.check_win(player2.symbol)
      play_turn(@player1)
      if @game_display.check_draw()
        puts "It's a DRAW!"
        break
      end 
      break if @game_display.check_win(@player1.symbol) 
      play_turn(@player2)
    end
  end
end


one_game = Game.new
p one_game.play_game


#disallow using the same symbol
#make the symbol one one char long
