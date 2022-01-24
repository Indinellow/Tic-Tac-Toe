class DisplayAndBoard
  attr_reader :current_display, :board
  
  def initialize()
    @board=[[1,2,3],[4,5,6],[7,8,9]]
    @current_display= "\n ----------- \n| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} | \n ----------- \n| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} | \n ------------ \n| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |\n ----------- \n "
  end

  def check_if_free(row,column)
    if @board[row][column].instance_of? Integer
      return true
    else 
      return false
    end
  end  

  def change_board(row,column,symbol)
    @board[row][column]=symbol
    update_display()
  end 

  def update_display()
    @current_display= "\n ----------- \n| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} | \n ----------- \n| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} | \n ------------ \n| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |\n ----------- \n "
  end

  def check_win(symbol)
  row_boolean = @board[0].all? {|element| element==symbol} || @board[1].all? {|element| element==symbol} || @board[0].all? {|element| element==symbol}

  column_boolean = (@board[0][0]==symbol && @board[1][0]==symbol && @board[2][0]==symbol) || (@board[0][1]==symbol && @board[1][1]==symbol && @board[2][1]==symbol) || (@board[0][2]==symbol && @board[1][2]==symbol && @board[2][2]==symbol)

  diagonal_boolean = (@board[0][0]==symbol && @board[1][1]==symbol && @board[2][2]==symbol) || (@board[0][2]==symbol && @board[1][1]==symbol && @board[2][0]==symbol)

  row_boolean || column_boolean || diagonal_boolean
  end

  def check_draw()
  board[0].none? {|element| element.instance_of? Integer} && board[1].none? {|element| element.instance_of? Integer} && board[2].none? {|element| element.instance_of? Integer}
  end
end

class Player
  attr_reader :name, :symbol
  def initialize(name,symbol)
    @name=name
    @symbol=symbol
  end
end 

class Game 
  attr_reader :game_display, :players
  def initialize()
    @players=Array.new()
    @game_display=DisplayAndBoard.new()
    for i in [1,2] do
      puts "Enter name for Player #{i}:"
      name=gets.chomp
      puts "Enter symbol for Player #{i}:"
      symbol=gets.chomp
      @players[i-1]=Player.new(name,symbol)
    end
  end 
  
  def translate_location(number)
    case number
    when 1
      return [0,0]
    when 2
      return [0,1]
    when 3
      return [0,2]
    when 4
      return [1,0]
    when 5
      return [1,1]
    when 6
      return [1,2]
    when 7
      return [2,0]
    when 8
      return [2,1]
    when 9
      return [2,2]
    end
  end 

  def choose_location(player)
    player_symbol=player.symbol
    puts "Pick a location #{player.name}"
    temporary_location = gets.chomp.to_i
    location= translate_location(temporary_location)
    if @game_display.check_if_free(location[0],location[1])
      @game_display.change_board(location[0],location[1],player_symbol)
    else
      puts "That space is already taken, please pick another one!"
      choose_location(player)
    end 
  end
end 


def play_one_game
  one_game = Game.new()
  puts one_game.game_display.current_display
  while(true)
    one_game.choose_location(one_game.players[0])
    if one_game.game_display.check_win(one_game.players[0].symbol)
      puts "Player #{one_game.players[0].name} won! Congratulations"
      puts one_game.game_display.current_display
      break
    end
    puts one_game.game_display.current_display

    if one_game.game_display.check_draw()
      puts "It's a DRAW!"
      break
    end 
    
    one_game.choose_location(one_game.players[1])
    if one_game.game_display.check_win(one_game.players[1].symbol)
      puts "Player #{one_game.players[1].name} won! Congratulations"
      puts one_game.game_display.current_display
      break
    end
    puts one_game.game_display.current_display
  end
  puts "Do you want to play another game? If so, type Yes"
  answer=gets.chomp.downcase
  if answer == "yes"
    puts "NEW GAME! "
    play_one_game()
  end 
end

play_one_game()
