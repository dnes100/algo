# Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.
# Return the number of good nodes in the binary tree.

require_relative './utils.rb'

def good_nodes(root, max = -Float::INFINITY)
  return 0 if root.nil?

  result = 0

  if root.data >= max
    max = root.data
    result += 1
  end

  result + good_nodes(root.left, max) + good_nodes(root.right, max)
end



puts "Good Nodes"
array = [3, 3, nil, 4, 2]
#array = [3,1,4, 3, nil, 1, 5]
root = FromArray.build(array)
puts "good_nodes: #{good_nodes(root)}"
