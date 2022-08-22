
def radix_sort(array)
  max = array.max
  result = []

  #  place corresponds to ones, tens, hundreds, etc
  place = 1
  while max / place > 0
    result = counter_sort(array, place)
    puts "place: #{place}, result: #{result.inspect}"
    place *= 10
  end

  result
end

def counter_sort(array, place)
  counts = []
  result = []

  # counts
  array.each.with_index do |x, i|
    # take correct integer in significant place
    # (1234 / 1) % 10 => 4
    # (1234 / 10) % 10 => 3
    # (1234 / 100) % 10 => 2
    index = (x / place) % 10
    if counts[index]
      counts[index] += 1
    else
      counts[index] = 1
    end
  end

  # cummulative counts
  counts[0] = 0 if counts[0].nil?
  (1...counts.length).each do |i|
    counts[i] = counts[i-1] + (counts[i] || 0)
  end

  array.each.with_index do |x, i|
    index = (x / place) % 10
    result[counts[index] - 1] = x
    counts[index] -= 1
  end

  result
end

arr = 10.times.map { (rand * 1000).floor }
puts arr.inspect
#puts counter_sort(arr, 1).inspect
puts radix_sort(arr).inspect
