# frozen_string_literal: true

# 'node.rb'

# Node Class
class Node
  include Comparable

  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end
