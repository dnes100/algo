require 'byebug'

class Node
  attr_accessor :data, :next_node

  def initialize(data: nil, next_node: nil)
    @data = data
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :root, :length

  def initialize(root)
    @length = 0
    if root.is_a?(Array)
      build_from_array(root)
    end

    if root.is_a?(Node)
      @root = root
    end
  end

  def reverse!
    current = @root
    pre = nil
    post = current.next_node

    loop do
      current.next_node = pre

      break if post.nil?

      pre = current
      current = post
      post = current.next_node
    end

    @root = current
  end


  def reverse_with_stack!
    stack = []

    node = @root
    while node
      stack.push node
      node = node.next_node
    end

    node = @root = stack.pop
    while !stack.empty?
      node.next_node = stack.pop
      node = node.next_node
    end
    node.next_node = nil
  end

  def reverse_recursively!
    first, last = do_reverse_recursively!(@root)
    @root = first
    last.next_node = nil
  end

  def do_reverse_recursively!(current)
    new_root = current.next_node
    if new_root.nil?
      return [current, current]
    end

    first, last = do_reverse_recursively!(new_root)
    last.next_node = current

    [first, current]
  end



  def build_from_array(array)
    @root = nil
    (array.length - 1).downto(0).each do |i|
      @root = Node.new(data: array[i], next_node: @root)
      @length += 1
    end
  end

  def to_a
    array = []
    node = @root
    while !node.nil?
      array.push node.data
      node = node.next_node
    end

    array
  end

end

puts "Reverse linked list"
array = (1..10).to_a
puts "#{'array:'.ljust(15)} #{array.inspect}"
list = LinkedList.new(array)
puts "#{'LinkedList:'.ljust(15)} #{list.to_a.inspect}"

list.reverse!
puts "#{'Reverse:'.ljust(15)} #{list.to_a.inspect}"
