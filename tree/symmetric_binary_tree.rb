require_relative './utils.rb'

class SymmetricBinaryTree
  attr_accessor :root

  def initialize(root: nil, array: nil)
    @root = array ? build_from_array(array) : root
  end

  # Symmeric if left branch is mirror image of right branch
  #   ie. root.left.left == root.right.right
  #   ie. root.left.right == root.right.left
  #                 4
  #           5           5
  #       2     8     8       2
  #     9  7  1         1   7   9
  #   3  0  6             6   0   3
  #
  def is_symmetric?
    is_mirror_image(root&.left, root&.right)
  end

  def is_mirror_image(x, y)
    return true if x.nil? && y.nil?
    return false if (x.nil? && y) || (x && y.nil?) # one of them is nil

    return false if x.data != y.data

    is_mirror_image(x.left, y.right) &&
      is_mirror_image(x.right, y.left)
  end

  private

  def build_from_array(array)
    FromArray.build(array)
  end
end

puts "SymmetricBinaryTree"
#array = (1..10).to_a
#tree = SymmetricBinaryTree.new(array:)
#puts tree.root.data
#puts "is symmetric: #{tree.is_symmetric?}"

#                 4
#           5           5
#       2     8     8       2
#     9  7  1         1   7   9
#   3  0  6             6   0   3

# array representing level order traversal
array = [4, 5, 5, 2, 8, 8, 2, 9, 7, 1, nil, nil, 1, 7, 9, 3, 0, 6, [nil] * 10, 6, 0, 3].flatten
tree = SymmetricBinaryTree.new(array:)
puts tree.root.data
puts "is symmetric: #{tree.is_symmetric?}"
