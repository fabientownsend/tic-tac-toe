class Policy
  def win?(board, mark)
    @mark = mark
    @board = board
    win_with_columns? || win_with_rows? || win_with_diagonal?
  end

  def win_with_columns?
    @board.transpose.any? { |column| same_symbole?(column) }
  end

  def win_with_rows?
    @board.any? { |row| same_symbole?(row) }
  end

  def same_symbole?(array)
    array.all? { |row| row == @mark }
  end

  def win_with_diagonal?
    if @board[0][0] == @mark && @board[1][1] == @mark && @board[2][2] == @mark
      true
    elsif @board[0][2] == @mark && @board[1][1] == @mark && @board[2][0] == @mark
      true
    else
      false
    end
  end

  private :win_with_columns?, :win_with_rows?, :win_with_diagonal?
end
