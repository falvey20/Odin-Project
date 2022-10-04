# frozen_string_literal: true

# 'linked_lists.rb'

require_relative 'node'

# LinkedList class ro represent full list
class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  # adds a new node containing value to the end of the list
  def append(value)
    new_node = Node.new(value)
    @head ||= new_node
    if !@tail
      @tail = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
  end

  # adds a new node containing value to the start of the list
  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  # returns the total number of nodes in the list
  def size
    count = 0
    curr_node = @head
    until curr_node.nil?
      count += 1
      curr_node = curr_node.next_node
    end
    count
  end

  # returns the node at the given index
  def at(index)
    curr_node = @head
    index.times do
      curr_node = curr_node.next_node
    end
    curr_node
  end

  # removes the last element from the list
  def pop
    nil if size < 1
    curr_node = @head
    curr_node = curr_node.next_node until curr_node.next_node == @tail
    curr_node.next_node = nil
    @tail = curr_node
  end

  # returns true if the value is in the list else returns false
  def contains?(value)
    curr_node = @head
    until curr_node.nil?
      return true if curr_node.data == value

      curr_node = curr_node.next_node
    end
    false
  end

  # returns the index of the node containing value else nil
  def find(value)
    curr_node = @head
    idx = 0
    until curr_node.nil?
      return idx if curr_node.data == value

      idx += 1
      curr_node = curr_node.next_node
    end
  end

  # prints LinkedList object as string
  def to_s
    curr_node = @head
    until curr_node.nil?
      print "( #{curr_node.data} ) -> "
      curr_node = curr_node.next_node
    end
    print 'nil'
  end

  # inserts a new node with given value at the given index
  def insert_at(value, index)
    if index > size
      return puts 'Error: You selected an index outside of the list'
    end

    if index.zero?
      prepend(value)
    else
      new_node = Node.new(value, at(index))
      prev_node = at(index - 1)
      prev_node.next_node = new_node
      @tail = new_node if new_node.next_node.nil?
    end
  end

  # remove node at the given index
  def remove_at(index)
    if index > size
      return puts 'Error: You selected an index outside of the list'
    end
    
    if index.zero?
      @head = at(1)
    elsif at(index) == @tail
      @tail = at(index - 1)
      @tail.next_node = nil
    else
      prev_node = at(index - 1)
      prev_node.next_node = at(index + 1)
    end
  end
end
