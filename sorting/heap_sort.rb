# heap sort by max heapify

def heap_sort(array)
  heapify_all(array)

  max_index = array.length - 1

  # repeatedly remove root (max) and remake the heap
  # We don't actually remove but move root (max) to the end
  (array.length - 1).downto(1).each do |i|
    # swap root (max) with current last node
    array[0], array[i] = array[i], array[0]

    # limit is i - 1, since last element is already sorted
    limit = i - 1
    heapify(array, 0, limit)
  end
end

def heapify_all(array)
  max_index = array.length - 1
  last_parent_index = (max_index - 1) / 2

  last_parent_index.downto(0).each do |i|
    heapify(array, i, max_index)
  end
end


# parent => current root index
# This is used to re-heapify tree after moving max root to the last node as well. In this case, nodes in single path is re-arranged.
def heapify(array, parent, limit)
  root = array[parent]
  # c: child_index
  c = 2 * parent + 1

  while c <= limit
    if (c < limit) && (array[c] < array[c + 1])
      c += 1
    end

    # if root is greater than greatest child this is already max heap.
    break if root >= array[c]

    # put child to root if child is greater
    array[parent] = array[c]

    parent = c
    c = 2*parent + 1
  end

  # at this point parent is the last child (basically swapping root <=> child)
  array[parent] = root
end


a1 = (1..20).to_a.reverse
puts a1.inspect
heap_sort(a1)
puts a1.inspect
