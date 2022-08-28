class KthMax
  attr_accessor :array

  def initialize(array)
    @array = array.dup
  end

  # Returns kth max element from the array
  # Option 1: sort descending order (O(nlogn)) + extract (n-k)th element
  # Option 2: max heapify k times (extracting root each time) (O(klogn))
  #           - this is better
  #
  def call(k)
    heapify_all

    (k-1).times do
      extract_max
    end

    array.first
  end

  def heapify_all
    last = array.length - 1
    last_parent = (last - 1) / 2

    last_parent.downto(0).each do |i|
      heapify_max_down(i, limit: last)
    end
  end

  def extract_max
    array.shift
    heapify_max_down(0, limit: array.length - 1)
  end

  def heapify_max_down(current, limit:)
    max = current
    left = 2 * current + 1
    right = left + 1

    [left, right].each do |child|
      next if child > limit
      next if array[child] <= array[max]

      max = child
    end

    return if max == current

    swap_at(max, current)
    heapify_max_down(max, limit:)
  end

  def swap_at(max, current)
    array[max], array[current] = array[current], array[max]
  end


end

puts "Kth max"

array = (1..10).to_a.shuffle
k = rand array.length
puts "array: #{array}, K: #{k}"
puts KthMax.new(array).call(k).to_s
