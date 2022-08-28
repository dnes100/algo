class HeapMin
  attr_accessor :array

  def initialize(array = [])
    @array = array
    heapify_all if @array.length > 1
  end

  def length
    array.length
  end

  def root
    array.first
  end
  alias_method :min, :root
  alias_method :peek, :root

  def add(element)
    array.push(element)
    heapify_up
    self
  end
  alias_method :insert, :add

  def extract
    # swap first and last
    array[0], array[length - 1] = array[length - 1], array[0]
    min = array.pop
    heapify_down(0)

    min
  end

  def delete_at(index)
    array[index], array[length-1] = array[length-1], array[index]
    deleted = array.pop
    heapify_down(index)

    deleted
  end

  # Loop through all parent (non-leaf) nodes (bottom up) and heapify each
  def heapify_all
    last_parent.downto(0).each do |i|
      heapify_down(i)
    end
  end

  # node: parent node (root for current subtree)
  #
  def heapify_down(node = last_parent)
    # parent
    min = node
    left = 2 * node + 1
    right = left + 1

    if left < length && array[left] < array[min]
      min = left
    end

    if right < length && array[right] < array[min]
      min = right
    end

    if min != node
      swap_at(min, node)
      # heapify all subtries down
      heapify_down(min)
    end
  end

  # Last non-leaf node
  #
  def last_parent
    (length - 2) / 2
  end

  # This can be used correctly only when adding new element to already heapified array
  # Cannot be used to heapify existing array
  def heapify_up
    child = length - 1
    parent = (child - 1)/2

    while child > 0 && array[parent] > array[child]
      swap_at(child, parent)
      child = parent
      parent = (child-1)/2
    end
  end

  def swap_at(i, j)
    array[i], array[j] = array[j], array[i]
  end

  def inspect
    "HeapMin: " + array.inspect
  end
  alias_method :to_s, :inspect
end

puts "Heap Min"
heap = HeapMin.new
puts heap
puts heap.add(9)
puts heap.add(19)
puts heap.add(20)
puts heap.add(21)
puts heap.add(15)
puts heap.add(8)

puts ' - '
array = (1..9).to_a.shuffle
puts array.inspect
heap = HeapMin.new array
puts heap
