# frozen_string_literal: true

# 'tree.rb'

require_relative 'node'

# Tree class
class Tree
  attr_accessor :data, :root

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  # build_tree takes array of sorted data
  # converts array to balanced binary tree full of Node objects
  # 1. Initialize start = 0, end = length of array -1
  # 2. mid = (start+end)/2
  # 3. Create a tree node with mid as root (eg A)
  # 4. Recursively do the following steps
  # 5. Calculate mid of left subarray and make it subtree of A
  # 6. Calculate mid of right subarray and make it right subtree of A
  def build_tree(array)
    return nil if array.empty?

    middle = array.length / 2
    root_node = Node.new(array[middle])

    root_node.left = build_tree(array[0...middle])
    root_node.right = build_tree(array[(middle + 1)..])

    root_node
  end

  # pretty print prints visualisation of binary search tree
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  # if node.data > value, recursively call delete
  # make node's left point to tree returned
  # if node.data < value, recursively call delete
  # make node's right point to tree returned
  # else if node is leaf node, delete node and return nil
  # else if node has 1 child delete node and return child
  # else find min value in right sub-tree and make that nodes value
  # recursively delete on right sub-tree to delete node value
  # make node right point to the tree returned from recursion
  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      delete(value, node.left)
    elsif value > node.data
      delete(value, node.right)
    else
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      # two children
      min_leaf_of_right_subtree = leftmost_leaf(node.right)
      node.data = min_leaf_of_right_subtree.data
      node.right = delete(min_leaf_of_right_subtree.data, node.right)
    end
    node
  end

  # finds the leftmost leaf of the given node
  def leftmost_leaf(node)
    node = node.left until node.left.nil?
    node
  end

  def find(value, node = @root)
    return node if node.nil? || node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  # returns an array of values traversing the tree breadth-first
  def level_order(node = @root, queue = [], output = [])
    return if node.nil?

    output << (block_given? ? yield(node) : node.data)
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return output if queue.empty?

    level_order(queue.shift, queue, output)
  end

  # returns an array of values in ascending order
  def inorder(node = @root, output = [], &block)
    return if node.nil?

    inorder(node.left, output, &block)
    output << (block_given? ? block.call(node) : node.data)
    inorder(node.right, output, &block)
    output
  end

  # return an array of values in order of insertion
  def preorder(node = @root, output = [], &block)
    return if node.nil?

    output << (block_given? ? block.call(node) : node.data)
    preorder(node.left, output, &block)
    preorder(node.right, output, &block)
    output
  end

  # returns array starting from leaves
  def postorder(node = @root, output = [], &block)
    return if node.nil?

    postorder(node.left, output, &block)
    postorder(node.right, output, &block)
    output << (block_given? ? block.call(node) : node.data)
    output
  end

  # accepts a node and returns its height. Returns -1 if node doesn't exist
  # height: number of edges from a node to the lowest leaf in its subtree
  def height(node = @root, count = -1)
    return count if node.nil?

    count += 1
    [height(node.left, count), height(node.right, count)].max
  end

  # accepts a node and returns its depth.
  # Depth is defined as the number of edges in path from a given node to the tree’s root node.
  def depth(node)
    return nil if node.nil?

    curr_node = @root
    count = 0
    until curr_node.data == node.data
      count += 1
      curr_node = curr_node.left if curr_node.data > node.data
      curr_node = curr_node.right if curr_node.data < node.data
    end
    count
  end

  # checks if a tree is balanced.
  # balanced tree when difference between heights of left subtree and right # subtree of every node is not more than 1.
  def balanced?(node = @root)
    return true if node.nil?

    lh = height(node.left)
    rh = height(node.right)

    # check if difference in heights for tree and each node are not more than 1.
    return true if (lh - rh).abs <= 1 && balanced?(node.left) == true && balanced?(node.right) == true

    false
  end

  # create a new balanced tree
  def rebalance(node = @root)
    arr = inorder(node)
    Tree.new(arr)
  end

  # rebalance the current Tree
  def rebalance!(node = @root)
    @data = inorder(node)
    @root = build_tree(@data)
  end
end
