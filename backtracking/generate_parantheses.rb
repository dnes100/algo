# Generates all valid combinations of '(' and ')' for given number of pairs 'n'
def generate_all_combinations(n)
  combs = []

  # length of characters '(', ')' is twice the number of pairs
  length = 2 * n

  generate(length:, combs:)

  combs
end

def generate(length: , diff: 0, comb: '', combs: [])
  if diff < 0 || diff > length
    # this combination doesn't work
    return
  end

  if length <= 0
    if diff == 0
      # this combination is valid, add to combs
      combs.push comb
    end

    return
  end

  generate(length: length - 1, diff: diff + 1, comb: comb + '(', combs:)
  generate(length: length - 1, diff: diff - 1, comb: comb + ')', combs:)
end

puts "Generate parentheses"
puts generate_all_combinations(13)
