require 'set'


# Edge list
# undirected paths connecting edges
#
# i -- j
# |
# k -- m
# |
# l
#
# o -- n
#
edges = [
  ['i', 'j'],
  ['k', 'i'],
  ['m', 'k'],
  ['k', 'l'],
  ['o', 'n'],
]


def undirected_path(graph, nodeA, nodeB)
  graph = build_graph(graph)
  pp graph

  visited = Set.new

  has_path_depth_first(graph, nodeA, nodeB, visited)
end

def has_path_depth_first(graph, src, dst, visited)
  return false if visited.include?(src)
  return true if src == dst

  visited.add src

  graph[src].each do |neighbour|
    return true if has_path_depth_first(graph, neighbour, dst, visited)
  end

  return false
end


# convert undirected edge list to adjacency list graph
def build_graph(edges)
  graph = {}

  edges.each do |a, b|
    graph[a] ||= []
    graph[b] ||= []

    graph[a].push b
    graph[b].push a
  end


  graph
end


puts "undirected_path(edges, 'j', 'm'): #{undirected_path(edges, 'j', 'm')}"
puts "undirected_path(edges, 'n', 'm'): #{undirected_path(edges, 'n', 'm')}"
puts "undirected_path(edges, 'n', 'o'): #{undirected_path(edges, 'n', 'o')}"
