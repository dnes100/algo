require 'set'
require 'byebug'

class Dijsktra
  attr_accessor :graph, :src, :dst,
    :visited, # set to track already visited nodes
    :distances, # for storing min cost and previous node, { node: { cost: 12, prev: 'node2' } }
    :queue # min priority queue array (can be implemented as min heap array), [{node: 'node', cost: 13, prev: 'node2'}]

  def initialize(graph, src, dst)
    @graph, @src, @dst = graph, src, dst
    @visited = Set.new
    src_distance = Distance.new(src, 0, nil)
    @queue = [src_distance]
    @distances = {}
  end

  def call
    while !@visited.include?(dst) || !@queue.empty?
      pp "queue: #{@queue.map{|a| a.node }.join(', ')}"

      current = @queue.shift

      @visited.add current.node

      if @distances[current.node].nil? || (current.cost < @distances[current.node].cost)
        @distances[current.node] = current
      end

      @graph[current.node].each do |neighbour, cost|
        explore(neighbour, cost, current)
      end
    end

    format_path
  end

  def explore(node, cost, current)
    return if @visited.include?(node)

    # add to queue if not visited already
    # queue should be sorted in ascending order of cost.
    total_cost = current.cost + cost
    distance = Distance.new(node, total_cost, current.node)
    @queue.push(distance)
    @queue.sort!

    #index = @queue.index { |a| a.cost > total_cost }
    #@queue.insert(index, distance)
  end

  def format_path
    result = [dst]

    loop do
      current = @distances[result.last]
      result.push current.prev
      break if current.prev == src
    end

    { path: result.reverse, cost: @distances[dst].cost }
  end


  class Distance
    include Comparable

    attr_accessor :node, :cost, :prev

    def initialize(node, cost, prev)
      @node, @cost, @prev = node, cost, prev
    end

    def <=>(other)
      cost <=> other.cost
    end

  end

end


graph = {
  'a' => { 'b' => 2, 'c' => 4 },
  'b' => { 'a' => 2, 'c' => 3, 'd' => 8 },
  'c' => { 'a' => 4, 'b' => 3, 'e' => 5, 'd' => 2 },
  'd' => { 'b' => 8, 'c' => 2, 'e' => 11, 'f' => 22 },
  'e' => { 'c' => 5, 'd' => 11, 'f' => 1 },
  'f' => { 'd' => 22, 'e' => 1 }
}

pp graph
pp "Dijsktra.new(graph, 'a', 'f').call: #{Dijsktra.new(graph, 'a', 'f').call}"

