# inputs: two strings
# Returns true/false
#
def are_anagrams(s1, s2)
  return false if s1.length != s2.length

  h1 = build_char_frequency(s1)
  h2 = build_char_frequency(s2)

  h1.each do |k, v|
    return false if h2[k] != v
  end

  true
end

def build_char_frequency(string)
  result = {}

  string.each_char do |x|
    result[x] ||= 0
    result[x] += 1
  end

  result
end

puts 'Anagram'
puts "are_anagrams('nameless', 'salesman'): #{are_anagrams('nameless', 'salesman')}"
puts "are_anagrams('hello', 'olleh'): #{are_anagrams('hello', 'olleh')}"
