# Adjacency list representation of graph:
# a -> c
# ↓    ↓
# b    e
# ↓
# d -> f
#
graph = {
  'a' => ['b', 'c'],
  'b' => ['d'],
  'c' => ['e'],
  'd' => ['f'],
  'e' => [],
  'f' => []
}

# Depth First Traversal: pick one branch first and travel to its end before moving to another branch.
# In above graph starting from a, there are two possible branches:
# a -> b -> d -> f and
# a -> c -> e


# Iterative using stack
def depth_first_print(graph, source)
  stack = [source]

  while stack.length > 0
    current = stack.pop
    puts current

    graph[current].each do |neighbour|
      stack.push neighbour
    end
  end
end


# Recursive
def depth_first_print_recursive(graph, source)
  puts source
  graph[source].each do |neighbour|
    depth_first_print_recursive(graph, neighbour)
  end
end



# prints: a, c, e, b, d, f
depth_first_print(graph, 'a')
puts '-'*10

# prints: a, b, d, f, c, e
depth_first_print_recursive(graph, 'a')
