class BinarySearch
  attr_accessor :array

  def initialize(array)
    @array = array
  end

  # Returns index of element x or -1
  def call(x, left: 0, right: array.length - 1)
    mid = (left + right) / 2
    puts "#{{x:, left:, right:, mid:}}"

    return -1 if left > right
    return mid if array[mid] == x

    if x < array[mid]
      return call(x, left: left, right: mid - 1)
    else
      return call(x, left: mid + 1, right: right)
    end
  end
end

puts "Binary Search"
puts "BinarySearch.new([2, 5, 6, 7, 9, 10, 45]).call(5): #{BinarySearch.new([2, 5, 6, 7, 9, 10, 45]).call(5)}"
puts "BinarySearch.new([2, 5, 6, 7, 9, 10, 45]).call(15): #{BinarySearch.new([2, 5, 6, 7, 9, 10, 45]).call(15)}"
expression = "BinarySearch.new([2]).call(3)"
puts "expression: #{eval(expression)}"
