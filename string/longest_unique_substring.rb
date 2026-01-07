require 'set'

def longest_unique_substring(str)
  visited = Set.new

  # i,j => start and end of substring
  i, j = 0, 0

  while j < str.length
    if visited.include?(str[j])
      i += 1
      visited.delete(str[j])
    end
  end
end
