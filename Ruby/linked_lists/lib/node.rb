# frozen_string_literal: true

# Node class contains #value method and link to next node
class Node
  attr_accessor :data, :next_node

  def initialize(data = nil, next_node = nil)
    @data = data
    @next_node = next_node
  end
end
