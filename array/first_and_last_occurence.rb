# find first and last occurances and return indices as an array: [first, last]
# array is sorted
# eg:
#   array: [2,4, 5,5,5,5,5,7,9,9]
#   target: 5
#   output: [2, 6]
# If element doesn't exist in the array, return [-1, -1]
#
def first_and_last_occurance_iterative(array, element)
  first, last = -1, -1

  array.each.with_index do |x, i|
    next if x != element

    first = i if first == -1

    if i < (array.length - 1) && array[i+1] != x
      last = i
      break
    end
  end

  [first, last]
end


def first_and_last_occurance_binary_search(array, element)
  return [-1, -1] if array.empty? || array.first > element || array.last < element

  left, right = nil, nil
  left = 0 if array[0] == element
  left = array.length - 1 if array.last == element

  left ||= lower_bound(array, element, 0, array.length-1)
  right ||= upper_bound(array, element, 0, array.length-1)

  [left, right]
end

def lower_bound(array, element, left, right)
  return -1 if left > right

  mid = left + (right - left)/2
  if array[mid] == element && array[mid-1] < element
    return mid
  end

  if array[mid] == element
    return lower_bound(array, element, left, mid - 1)
  else
    return lower_bound(array, element, mid + 1, right)
  end
end

def upper_bound(array, element, left, right)
  return -1 if left > right

  mid = left + (right - left)/2
  if array[mid] == element && array[mid+1] > element
    return mid
  end

  if array[mid] == element
    return upper_bound(array, element, mid + 1, right)
  else
    return upper_bound(array, element, left, mid - 1)
  end
end


puts "First and last occurances"

puts "1. Iterative implementation"
expression = "first_and_last_occurance_iterative([2, 4, 5, 5, 5, 5, 5, 7, 9], 5)"
puts "#{expression}: #{eval(expression)}"

puts "2. binary search implementation"
expression = "first_and_last_occurance_binary_search([2, 4, 5, 5, 5, 5, 5, 7, 9], 5)"
puts "#{expression}: #{eval(expression)}"
