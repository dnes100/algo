# sort ascending
class SortHeapMax
  attr_accessor :array

  def initialize(array)
    @array = array
  end

  def call
    heapify_all
    extract_maxs
    array
  end

  def heapify_all
    last = array.length - 1
    last_parent = (last - 1)/2

    last_parent.downto(0).each do |i|
      heapify_down(i, limit: last)
    end
  end

  def extract_maxs
    last = array.length - 1
    last.downto(1).each do |i|
      # move max(first) to last
      swap_at(0, i)
      heapify_down(0, limit: i-1)
    end
  end

  def heapify_down(node, limit:)
    max = node
    left = 2 * node + 1
    right = left + 1

    [left, right].each do |child|
      next if child > limit
      next if array[child] <= array[max]
      max = child
    end

    # return if current node is greater than both children
    return if max == node

    swap_at(max, node)
    heapify_down(max, limit:)
  end

  def swap_at(i, j)
    array[i], array[j] = array[j], array[i]
  end
end


puts "SortHeapMax (sorting array in ascending order)"
array = (1..10).to_a.shuffle
puts array.to_s
puts SortHeapMax.new(array).call.to_s
