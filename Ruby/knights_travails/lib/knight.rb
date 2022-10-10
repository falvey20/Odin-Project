# frozen_string_literal: true

# 'knight.rb'

# class Knight
class KnightNode
  attr_reader :position, :parent

  DIRECTIONS = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]].freeze

  def initialize(position, parent)
    @position = position
    @parent = parent
    @visited = []
    @visited << position
  end

  def possible_moves
    moves = DIRECTIONS.map { |d| [@position[0] + d[0], @position[1] + d[1]] }

    moves.reject! { |m| ((m[0]).negative? || m[0] > 7) || ((m[1]).negative? || m[1] > 7) }

    moves.reject! { |m| @visited.include?(m) }

    moves.map { |m| KnightNode.new(m, self) }
  end
end
