require 'set'

# L: Land, W: Water
# Island: Clusters of L
#
grid = [
  ['W', 'L', 'W', 'W', 'W'],
  ['W', 'L', 'W', 'W', 'W'],
  ['W', 'W', 'W', 'L', 'W'],
  ['W', 'W', 'L', 'L', 'W'],
  ['L', 'W', 'W', 'L', 'L'],
  ['L', 'L', 'W', 'W', 'W'],
]

class IslandCount
  attr_accessor :grid, :visited, :count

  def initialize(grid)
    @grid = grid
    @visited = Set.new
    @count = 0
  end

  def call
    0.upto(grid.length).each do |row|
      0.upto(grid[0].length).each do |column|
        if explore(row, column)
          @count += 1
        end
      end
    end

    @count
  end

  # Depth first traversal
  def explore(row, column)
    cell = Cell.new(row, column)
    return false if !cell.inbound?(grid)

    # check if water
    return false if grid[row][column] == 'W'

    # Set uses Hash internally, so key equality check is controlled by overriding eql? method in Cell.
    # Also we need to override 'hash' method so same row, column pair generates same lookup hash value.
    #
    return false if visited.include? cell
    visited.add cell

    explore(row - 1, column)
    explore(row + 1, column)
    explore(row, column - 1)
    explore(row, column + 1)

    true
  end


  # Cell instances are stored in visited Set above.
  # Set uses Hash internally, so key equality check is controlled by overriding eql? method in Cell.
  # Also we need to override 'hash' method so same row, column pair generates same lookup hash value.
  #
  class Cell
    attr_accessor :row, :column

    def initialize(row, column)
      @row, @column = row, column
    end

    def inbound?(grid)
      0 <= row && row < grid.length &&
        0 <= column && column < grid.first.length
    end

    def eql?(other)
      row == other.row && column == other.column
    end

    def hash
      [row, column].hash
    end
  end

end


puts IslandCount.new(grid).call
