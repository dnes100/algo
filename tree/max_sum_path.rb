class BinaryTree
  attr_accessor :root

  # array should represent complete binary tree
  def build_from_array(array)
    self.root = FromArray.build(array)
  end

  def to_a
    ToArray.call(root)
  end

  # number of edges (connectors) from root node to farthest leaf
  def height(node = root)
    return 0 if node.nil?

    1 + [height(node.left), height(node.right)].max
  end

  def balanced?(node = root)
    BalancedCheck.balanced?(node)
  end

  # This is inefficient way to find if tree is balanced
  # since it calculates height for single node multiple times
  #
  def balanced2?(node = root)
    (height(node.left) - height(node.right)).abs <= 0 &&
      balanced?(node.left) &&
      balanced?(node.right)
  end

  def max_sum_path(node = root)
    MaxPathSum.new.call(node)
  end

  # Returns true if tree is binary search tree
  # data at left < node < right && left.bst? && right.bst?
  def bst?
    BstCheck.bst?(root)
  end

  class BalancedCheck
    def self.balanced?(node)
      check_balanced(node) >= 0
    end

    # Returns 0 if node is nil, -1 if unbalanced, height if balanced
    def self.check_balanced(node)
      return 0 if node.nil?

      height_left = check_balanced(node.left)
      return -1 if height_left == -1

      height_right = check_balanced(node.right)
      return -1 if height_right == -1

      if (height_left - height_right).abs > 1
        return -1
      end

      return [height_left, height_right].max + 1
    end
  end

  # Returns true if tree is binary search tree
  # data at left < node < right && left.bst? && right.bst?
  #
  class BstCheckOne
    def self.call(node)
      isBst?(node, -Float::INFINITY, Float::INFINITY)
    end

    def self.isBst?(node, min, max)
      return true if node.nil?

      return false if node.data < min || node.data > max

      isBst?(node.left, min, node.data) && isBst?(node.right, node.data, max)
    end
  end

  class BstCheckTwo
    def self.bst?(node)
      call(node).is_bst
    end

    def.self call(node)
      return Data.new if node.nil?

      left_data = call(node.left)
      right_data = call(node.right)

      Data.new(
        min: [node.data, left_data.min].min,
        max: [node.data, right_data.max].max,
        is_bst: left_data.is_bst && right_data.is_bst && (left_data.max < node.data) && (node.data < right_data.min)
      )
    end

    class Data
      attr_accessor :min, :max, :is_bst

      def initialize(min: -Float::INFINITY, max: Float::INFINITY)
        @min = min
        @max = max
      end

    end
  end

  # Finds maximum path sum.
  # The path may start and end at any node in the tree.
  #
  class MaxPathSum
    def initialize
      @max = -Float::INFINITY
    end

    def call(node)
      max_sum_path(node)

      @max
    end

    def max_sum_path(node)
      return 0 if node.nil?

      # We need to compare with 0 here to ignore nodes with large negative data.
      # eg: in nod path: 3, 2, 10, -5, 2, 1
      #     max sum path would be: 3, 2, 10 => sum: 23.
      #     ignoring -5, 2, 1 because -5 + 2 + 1 = -2 which is negative.
      max_left = [0, max_sum_path(node.left)].max
      max_right = [0, max_sum_path(node.right)].max

      @max = [@max, (node.data + max_left + max_right)].max

      node.data + [max_left, max_right].max
    end
  end

  class ToArray
    def self.call(node)
      result = []
      add_to_array(node, result, 0)

      result
    end

    def self.add_to_array(node, array, index)
      return if node.nil?

      array[index] = node.data

      add_to_array(node.left, array, 2*index + 1) if node.left
      add_to_array(node.right, array, 2*index + 2) if node.right
    end
  end


  class FromArray
    def self.build(array, index: 0)
      return nil if index >= array.length

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
end













=begin
root = Node.new(
  data: 1,
  left: Node.new(
    data: 6,
    left: Node.new(
      data: 3,
      left: Node.new(data: 3),
      right: Node.new(data: 5)
    ),
    right: Node.new(
      data: -2,
      left: Node.new(data: -3),
      right: Node.new(data: 4),
    )
  ),
  right: Node.new(
    data: -1,
    left: Node.new(
      data: 4,
      left: Node.new(data: 1),
      right: Node.new(data: 2)
    ),
    right: Node.new(data: 1)
  )
)
=end

arr = [1, 6, -1, 3, -2, 4, 1, 3, 5, -3, 4, 1, 2]
puts "#{'Original array: '.ljust(20)} #{arr.inspect}"
tree = BinaryTree.new
tree.build_from_array(arr)
puts tree.root.data
puts tree.root.left.left.left.data

puts "#{'Tree to array:'.ljust(20)} #{tree.to_a.inspect}"
puts "Max sum path: #{tree.max_sum_path}"

arr1 = [1, 6, -1, 3, -2, 4, 1, 3, 5, -3, -4, 1, 2]
puts "#{'Original array1: '.ljust(20)} #{arr.inspect}"
tree1 = BinaryTree.new
tree1.build_from_array(arr1)
puts tree1.root.data
puts tree1.root.left.left.left.data

puts "#{'Tree to array1:'.ljust(20)} #{tree1.to_a.inspect}"
puts "Max sum path: #{tree1.max_sum_path(tree1.root.left)}"
