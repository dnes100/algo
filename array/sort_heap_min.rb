# Min heap to sort in descending order. Max heap for ascending order
class SortHeapMin
  attr_accessor :array

  def initialize(array)
    @array = array
  end

  def call
    heapify_all
    extract_mins
    array
  end

  def heapify_all
    # loop through all parents bottom up and heapify down at each
    last_parent.downto(0).each do |i|
      heapify_down(i)
    end
  end

  # extract root one by one
  # swap root <-> last and heapify_down at node 0,
  # but excluding last element each time since last element is already sorted.
  def extract_mins
    puts array.to_s
    (array.length - 1).downto(1).each do |i|
      #require 'byebug'; byebug
      swap_at(0, i)
      puts "extract_mins: #{array}, i: #{i}"
      heapify_down(0, limit: i - 1)
      puts "extract_mins: #{array}, i: #{i}"
    end
  end

  def heapify_down(node, limit: array.length - 1)
    min = node
    left = 2 * node + 1

    if (left <= limit && array[left] < array[min])
        min = left
    end

    right = left + 1
    if (right <= limit && array[right] < array[min])
        min = right
    end

    if min != node
      swap_at(min, node)
      heapify_down(min, limit:)
    end
  end

  def swap_at(i, j)
    array[i], array[j] = array[j], array[i]
  end

  def last_parent
    # last element (child) = array.length - 1
    # parent = (child - 1) / 2
    (array.length - 2) / 2
  end

  def is_min_heap?(array, node: 0)
    left = 2 * node + 1
    is_left_heap = (left < array.length) ? (array[node] < array[left] && is_min_heap?(array, node: left))  : true

    right = left + 1
    is_right_heap = (right < array.length) ? (array[node] < array[right] && is_min_heap?(array, node: right))  : true

    is_left_heap && is_right_heap
  end
end

puts "Sort heap min (descending)"
puts 'Is min heap?'
array = (1..10).to_a.shuffle
puts array.to_s
ss = SortHeapMin.new(array)
puts ss.is_min_heap?(array)
ss.heapify_all
puts "heapified: #{ss.array}"
puts ss.is_min_heap?(array)
puts '- -'
array = (1..10).to_a.reverse
puts array.to_s
expression = "SortHeapMin.new(array).call"
puts "#{expression}: #{eval expression}"
