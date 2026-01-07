def flatten(array)
  result = []

  array.each do |x|
    if x.is_a?(Array)
      x.each do |y|
        result << y
      end
    else
      result << x
    end
  end

  result
end

puts 'Flatten array'
array = [1,2,3,[4,5],6]
puts "array: #{array}"
puts "Flatten: #{flatten(array)}"
