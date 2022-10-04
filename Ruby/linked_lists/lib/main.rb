# frozen_string_literal: true

# 'main.rb'

# frozen_string_literal: true

require_relative 'linked_list'

my_linked_list = LinkedList.new
puts my_linked_list
my_linked_list.append('last')
puts my_linked_list
my_linked_list.prepend('first')
puts my_linked_list
puts "Size: #{my_linked_list.size}"
puts "Head: #{my_linked_list.head.data}"
puts "Tail: #{my_linked_list.tail.data}"
puts "At 1: #{my_linked_list.at(1).data}"
my_linked_list.pop
puts my_linked_list
puts "Contains 'first': #{my_linked_list.contains?('first')}"
puts "Contains 'last': #{my_linked_list.contains?('last')}"
puts "Index of 'first': #{my_linked_list.find('first')}"
my_linked_list.insert_at('new_first', 0)
my_linked_list.insert_at('new_last', 2)
puts my_linked_list
my_linked_list.remove_at(1)
puts my_linked_list

