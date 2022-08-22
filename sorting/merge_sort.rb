require 'byebug'

def merge_sort(array)
  return array if array.length <= 1

  mid = array.length / 2

  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid...(array.length)])
  merge(left, right)
end

def merge(left, right)
  result = []

  while left.length > 0 && right.length > 0
    if left[0] == right[0]
      result.push left.shift
      result.push right.shift
    elsif left[0] < right[0]
      result.push left.shift
    else
      result.push right.shift
    end
  end

  # At this point one of left or right is surely empty
  result.concat(left).concat(right)
end


sorted = (1..(10)**6).to_a
puts sorted.inspect
shuffled = sorted.shuffle
puts shuffled.inspect

result = merge_sort shuffled
puts result.inspect
puts sorted == result
