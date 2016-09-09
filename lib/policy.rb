class Policy

  def win?(mark)
    @mark = mark
  end

  def same_symbole?(line)
    line.all? { |row| row == "X" }
  end

  def win_columns?(board)
    board.transpose.any? { |column| same_symbole?(column) }
  end

  def win_rows?(board)
    board.any? { |row| same_symbole?(row) }
  end

  def win_diagonal(board)
    if board[0][0] == "X" && board[1][1] == "X" && board[2][2] == "X"
      true
    elsif board[0][2] == "X" && board[1][1] == "X" && board[2][0] == "X"
      true
    else
      false
    end
  end
end
