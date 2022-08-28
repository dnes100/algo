# Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
# You must implement a solution with a linear runtime complexity and use only constant extra space.
# [2,2,1] => 1
# [4, 1, 2, 1, 2] => 4

def single_number(array)
  array.reduce do |x, result|
    result = result ^ x
  end
end

pp single_number([2,2,1])
pp single_number([4, 1, 2, 1, 2])


# rotate array to right k times
def rotate_right(array, k)
  x = k % array.length

  # First solution
  (array.length - k).times do
    array.push array.shift
  end

  # Second solution
  #x.downto(1).each do |i|
  #  array.prepend(array.pop)
  #end

  # Third solution
  # shift(n) and push(n) at once

  array
end

pp rotate_right([1,2,3,4,5,6,7], 3)
