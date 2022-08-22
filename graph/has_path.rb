# Adjacency list representation of graph:
graph = {
  'f' => ['g', 'i'],
  'g' => ['h'],
  'h' => [],
  'i' => ['g', 'k'],
  'j' => ['i'],
  'k' => []
}


# This doesn't handle cyclic graph (infinite loops)
# depth first
def has_path_depth_first(graph, src, dst)
  return true if src == dst

  graph[src].each do |neighbour|
    if has_path_depth_first(graph, neighbour, dst)
      return true
    end
  end

  return false
end

# No recursive solution for breadth first, have to use queue
def has_path_breadth_first(graph, src, dst)
  queue = [src]

  while !queue.empty?
    current = queue.shift
    return true if current == dst

    # pushes all neighbours of current to queue
    queue.push *graph[current]
  end

  return false
end

puts "has_path_depth_first(graph, 'f', 'k'): #{has_path_depth_first(graph, 'f', 'k')}"
puts "has_path_depth_first(graph, 'f', 'j'): #{has_path_depth_first(graph, 'f', 'j')}"
puts "has_path_depth_first(graph, 'k', 'j'): #{has_path_depth_first(graph, 'k', 'j')}"
puts "-" * 10
puts "has_path_breadth_first(graph, 'f', 'k'): #{has_path_breadth_first(graph, 'f', 'k')}"
puts "has_path_breadth_first(graph, 'f', 'j'): #{has_path_breadth_first(graph, 'f', 'j')}"
puts "has_path_breadth_first(graph, 'k', 'j'): #{has_path_breadth_first(graph, 'k', 'j')}"
