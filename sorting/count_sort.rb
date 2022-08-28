
def count_sort(array)
  # Initializes counts with array.max elements, each element filled with 0
  # counts = Array.new(array.max, 0)
  counts = []
  result = []

  # fill in counts of each element
  array.each.with_index do |x, i|
    if counts[x]
      counts[x] += 1
    else
      counts[x] = 1
    end
  end

  # convert counts to cumulative frequency
  0.upto(counts.length - 2).each do |i|
    counts[i+1] = (counts[i] || 0) + (counts[i+1] || 0)
  end

  # insert elements in correct position in the result array based on cummulative frequency from counts array
  (array.length - 1).downto(0).each do |i|
    # final position of item => cumulative freq - 1, since cumulative freq starts from 1 (not 0)
    result[counts[array[i]] - 1] = array[i]
    counts[array[i]] -= 1
  end

  # Alternative without calculating cummulative counts
  # This alternative might not be stable sorting
  # counts.each.with_index do |x, i|
  #   # x => counts/frequency, i => value
  #   while counts[i] != nil && counts[i] > 0
  #     result.push i
  #     counts[i] -= 1
  #   end
  # end

  result
end


=begin
0 1 2 3 4 5 i
2 1 0 2 2 2
2 3 3 5 7 9 v


0 1 2 3 4 5 6 7 8 i
0 0 1 3 3 4 4 5 5
=end

arr = 10.times.map { (rand * 10).floor }
input = arr.shuffle
puts input.inspect
output = count_sort input
puts output.inspect
