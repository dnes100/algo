# Builds binary tree from array
# Returns root node
class FromArray
  def self.build(array, index: 0)
    #return nil if index >= array.length
    return nil if array[index].nil?

    node = Node.new(data: array[index])

    left_index = (2 * index) + 1
    right_index = left_index + 1

    node.left = build(array, index: left_index)
    node.right = build(array, index: right_index)

    node
  end
end


class Node
  attr_accessor :data, :left, :right

  def initialize(data: nil, left: nil, right: nil)
    @data = data
    @left = left
    @right = right
  end

  def leaf?
    left.nil? && right.nil?
  end
end
