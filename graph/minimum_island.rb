require 'set'

class MinimumIsland
  attr_accessor :grid, :min, :visited

  def initialize(grid)
    @grid = grid
    @visited = Set.new
    @min = 0
  end

  def call
    0.upto(grid.length).each do |row|
      0.upto(grid.first.length).each do |column|
        cell = Cell.new(row, column)
        size = explore(cell)

        if size > 0
          @min = size if @min == 0 || size < @min
        end
      end
    end

    @min
  end

  # returns size/length of island
  #
  def explore(cell)
    return 0 if !cell.inbound?(grid)
    return 0 if grid[cell.row][cell.column] == 'W'

    return 0 if visited.include?(cell)
    visited.add cell

    size = 1
    size = size + explore(cell.left)
    size = size + explore(cell.right)
    size = size + explore(cell.up)
    size = size + explore(cell.down)

    size
  end

  class Cell
    attr_accessor :row, :column

    def initialize(row, column)
      @row, @column = row, column
    end

    def inbound?(grid)
      0 <= row && row < grid.length &&
        0 <= column && column < grid.first.length
    end

    def left
      Cell.new(row, column - 1)
    end

    def right
      Cell.new(row, column + 1)
    end

    def up
      Cell.new(row - 1, column)
    end

    def down
      Cell.new(row + 1, column)
    end

    def eql?(other)
      row == other.row && column == other.column
    end

    def hash
      [row, column].hash
    end
  end
end


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

puts MinimumIsland.new(grid).call
