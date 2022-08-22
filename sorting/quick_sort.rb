def quick_sort(array)
  do_quick_sort(array, 0, array.length - 1)
end

def do_quick_sort(array, left, right)
  return if left >= right

  pivot_index = partition(array, left, right)

  do_quick_sort(array, left, pivot_index - 1)
  do_quick_sort(array, pivot_index + 1, right)
end

def partition(array, left, right)
  # Select any element as pivot, here selecting last
  pivot = array[right]

  # pivot_index tracks first element > pivot,
  # at the end of this function, this should be final position of pivot
  pivot_index = left

  # loop excluding last one (pivot) to compare each with pivot
  (left...right).each do |i|
    # Do nothing if current item is larger than pivot
    next if array[i] >= pivot

    # swap i <-> pivot_index if current item is smaller
    # this will move smaller item towards left side
    array[pivot_index], array[i] = array[i], array[pivot_index]
    pivot_index += 1
  end

  # p_index, now, is the final position where pivot belongs to
  array[pivot_index], array[right] = array[right], array[pivot_index]

  pivot_index
end

sorted = (1..10).to_a
shuffled = sorted.shuffle
#puts shuffled.inspect
quick_sort shuffled

pass = sorted == shuffled
#puts shuffled.inspect
puts pass
