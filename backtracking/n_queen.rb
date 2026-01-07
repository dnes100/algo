# Place N queens in Chess board (NxN) so that no queens see each other.
# N: chess board size

class Chess
  attr_accessor :board, :size

  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) { '.'  } }
  end

  def n_queens
    if solve_n_queens
      print_board
    else
      puts "Solution does not exist!"
    end
  end

  def solve_n_queens(column: 0)
    # all columns has been filled with queens
    return true if column >= size

    # try all rows one by one
    (0...size).each do |row|
      next if !is_safe(row:, column:)

      @board[row][column] = 'Q'

      return true if solve_n_queens(column: column + 1)

      # last try didn't work, so bracktrack (go back)
      @board[row][column] = '.'
    end

    # if all rows has been checked, there is no solution
    false
  end

  # Check if queen at [row, column] cell doesn't see other queens in the left.
  # Checking in left part of board is enough since we start filling from left.
  #
  def is_safe(row:, column:)
    # check same row (left part)
    (0...column).each do |c|
      return false if @board[row][c] == 'Q'
    end

    # check top-left diagonal
    tr = row - 1
    tc = column - 1
    while tr >= 0 && tc >= 0
      return false if @board[tr][tc] == 'Q'
      tr -= 1
      tc -= 1
    end

    # check bottom-left diagonal
    tr = row + 1
    tc = column - 1
    while tr < size && tc >= 0
      return false if @board[tr][tc] == 'Q'
      tr += 1
      tc -= 1
    end

    true
  end

  def print_board
    @board.each do |row|
      row.each do |cell|
        print ' '
        print cell
      end
      print "\n"
    end
  end
end

puts "N queen"
n = 8
cc = Chess.new(n)
cc.print_board
puts " - #{n} Queens -"
cc.n_queens
