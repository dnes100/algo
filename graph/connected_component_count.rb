require 'set'

def connected_component_count(graph)
  visited = Set.new
  count = 0

  graph.each do |node, _|
    if explore(graph, node, visited)
      count += 1
    end
  end

  count
end

# Depth first traversal
def explore(graph, current, visited)
  return false if visited.include?(current)

  visited.add current

  graph[current].each do |neighbour|
    explore(graph, neighbour, visited)
  end

  true
end


graph = {
  0 => [8, 1, 5],
  1 => [0],
  5 => [0, 8],
  8 => [0, 5],
  2 => [3, 4],
  3 => [2, 4],
  4 => [3, 2],
}

puts "connected_component_count(graph): #{connected_component_count(graph)}"
