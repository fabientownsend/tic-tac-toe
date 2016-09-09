class Policy
  def win_row?(line)
    line.all? { |row| row == "X" }
  end

  def win_each_colum(board)
    result = false

    board.transpose.each do |a|
      if win_row?(a)
        result = true
      end
    end

    result
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
