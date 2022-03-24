class DisplayAndBoard
  attr_reader :current_display, :board

  def initialize()
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @current_display= "\n ----------- \n| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} | \n ----------- \n| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} | \n ------------ \n| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |\n ----------- \n "
  end

  def check_if_free(row, column,board = @board)
    board[row][column].instance_of? Integer
  end

  def change_board(row,column,symbol)
    @board[row][column]=symbol
    update_display()
  end 

  def update_display()
    @current_display= "\n ----------- \n| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} | \n ----------- \n| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} | \n ------------ \n| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |\n ----------- \n "
  end

  def check_win_row(symbol,board = @board)
    board[0].all? {|element| element==symbol} || @board[1].all? {|element| element==symbol} || @board[0].all? {|element| element==symbol}
  end

  def check_win_column(symbol,board = @board)
    column_boolean_1 = (board[0][0]==symbol && board[1][0]==symbol && board[2][0]==symbol)
    column_boolean_2 = (board[0][1]==symbol && board[1][1]==symbol && board[2][1]==symbol)
    column_boolean_3 = (board[0][2]==symbol && board[1][2]==symbol && board[2][2]==symbol)

    column_boolean_1 || column_boolean_2 || column_boolean_3
  end

  def check_win_diagonal(symbol, board = @board)
    diagonal_boolean_1 = (board[0][0]==symbol && board[1][1]==symbol && board[2][2]==symbol)
    diagonal_boolean_2 = (board[0][2]==symbol && board[1][1]==symbol && board[2][0]==symbol)
    diagonal_boolean_1 || diagonal_boolean_2
  end

  def check_win(symbol,board = @board)
    check_win_row(symbol,board) || check_win_column(symbol,board) || check_win_diagonal(symbol,board)
  end

  def check_draw(board = @board)
  board[0].none? {|element| element.instance_of? Integer} && board[1].none? {|element| element.instance_of? Integer} && board[2].none? {|element| element.instance_of? Integer}
  end
end