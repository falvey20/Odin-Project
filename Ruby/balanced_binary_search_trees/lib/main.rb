# frozen_string_literal: true

require_relative 'tree'

rand_num_arr = Array.new(15) { rand(1..100) }

# create tree
puts 'Balanced Binary Search Tree of random numbers:'
puts "\n"
my_tree = Tree.new(rand_num_arr)
my_tree.pretty_print

# check if tree is balanced
puts "Is Tree balanced: #{my_tree.balanced?}"

# print out all elements in level, pre, post, and in order
puts "Level Order: #{my_tree.level_order}"
puts "Preorder: #{my_tree.preorder}"
puts "Postorder: #{my_tree.postorder}"
puts "In Order: #{my_tree.inorder}"

# unbalance tree by adding numbers larger than 100 (curr max)
more_rand_nums = Array.new(5) { rand(100..200) }
more_rand_nums.each { |n| my_tree.insert(n) }
my_tree.pretty_print
puts "Is Tree balanced: #{my_tree.balanced?}"

# rebalance the tree
my_tree.rebalance!
my_tree.pretty_print
puts "Is tree balanced: #{my_tree.balanced?}"

# print out all elements in level, pre, post, and in order
puts "Level Order: #{my_tree.level_order}"
puts "Preorder: #{my_tree.preorder}"
puts "Postorder: #{my_tree.postorder}"
puts "In Order: #{my_tree.inorder}"
