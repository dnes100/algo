require 'set'


# For finding shortest distance from src to dst nodes,
# Breadth first traversal should be used. (Depth first algorithm performs poorly.)
#
class ShortestDistance
  attr_accessor :graph, :src, :dst, :queue, :visited

  def initialize(graph, src, dst)
    if graph.is_a?(Array)
      @graph = convert_edge_to_graph(graph)
    else
      @graph = graph
    end

    @src, @dst = src, dst
    @queue = [Distance.new(src, 0)]
    @visited = Set.new [src]
  end

  # Returns shortest distance
  def call
    while !queue.empty?
      current = @queue.shift

      # return current.distance if current.node == @dst

      @graph[current.node].each do |neighbour|
        if neighbour == dst
          return current.distance + 1
        end

        next if @visited.include?(neighbour)

        @visited.add neighbour

        distance = current.distance + 1
        @queue.push Distance.new(neighbour, distance)
      end
    end

    # No path from src to dst
    return -1
  end

  def convert_edge_to_graph(graph)
    result = {}
    graph.each do |a, b|
      result[a] ||= []
      result[b] ||= []

      result[a].push(b) unless result[a].include?(b)
      result[b].push(a) unless result[b].include?(a)
    end

    result
  end

  class Distance
    attr_accessor :node, :distance

    def initialize(node, distance)
      @node, @distance = node, distance
    end
  end
end


edges = [
  ['w', 'x'],
  ['x', 'y'],
  ['z', 'y'],
  ['z', 'v'],
  ['w', 'v'],
  ['p', 'q']
]

puts "ShortestDistance.new(edges, 'w', 'z').call: #{ShortestDistance.new(edges, 'w', 'z').call}"
puts "ShortestDistance.new(edges, 'w', 'x').call: #{ShortestDistance.new(edges, 'w', 'x').call}"
puts "ShortestDistance.new(edges, 'w', 'q').call: #{ShortestDistance.new(edges, 'w', 'q').call}"
