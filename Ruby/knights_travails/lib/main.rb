# frozen_string_literal: true

# 'main.rb'

require_relative 'knight'

def knight_route(node, output = [])
  knight_route(node.parent, output) unless node.parent.nil?

  output << node.position
end

def display_route(route)
  arr = route
  puts "The shortest route was in #{arr.length - 1} moves."
  arr.each_with_index { |x, i| puts "#{i} : #{x}" }
end

def knight_moves(start_position, end_position)
  queue = []
  curr_node = KnightNode.new(start_position, nil)

  until curr_node.position == end_position
    curr_node.possible_moves.each { |move| queue.push(move) }
    curr_node = queue.shift
  end
  display_route(knight_route(curr_node))
end

knight_moves([6, 2], [1, 1])
knight_moves([3, 4], [5, 2])
