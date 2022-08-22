require 'set'

# finds number of nodes in largest component
#
class LargestComponent
  attr_accessor :graph, :visited, :max_count

  def initialize(graph)
    @graph = graph
    @visited = Set.new
    @max_count = 0
  end

  def call
    graph.each do |node, _|
      current_count = explore_size(node)
      if current_count > @max_count
        @max_count = current_count
      end
    end

    @max_count
  end

  # Depth first traversal
  # Returns size of the component (nodes island)
  #
  def explore_size(node)
    return 0 if @visited.include?(node)

    @visited.add node
    count = 1

    @graph[node].each do |neighbour|
      count += explore_size(neighbour)
    end

    return count
  end
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

puts "LargestComponent.new(graph).call: #{LargestComponent.new(graph).call}"
