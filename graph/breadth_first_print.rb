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

# Breadth First Traversal: go through all immediate neighbour of source first
# eg: a, b, c, d, e, f


# Iterative implemention, Using queue
def breath_first_print(graph, source)
  queue = [source]

  while queue.length > 0
    current = queue.shift
    puts current

    graph[current].each do |neighbour|
      queue.push neighbour
    end
  end
end

breath_first_print(graph, 'a')
