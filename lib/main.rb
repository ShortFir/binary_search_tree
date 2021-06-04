# frozen_string_literal: true

require_relative 'tree'

# Do not use duplicate values because they make it more complicated
# and result in trees that are much harder to balance. Therefore,
# be sure to always remove duplicate values or check for an existing
# value before inserting.

# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# print "\n", array.sort!.uniq!, "\n\n"
# tree = Tree.new(array)
# puts
# tree.pretty_print
# puts
# puts tree.find(23).data
# puts
# puts tree.root.data == tree.root.right.data

array = Array.new(25) { rand(1..100) }
tree = Tree.new(array)

print "\n#{array.sort.uniq}, length = #{array.sort.uniq.length}\n\n"
tree.pretty_print
puts
print 'find(23) = ', tree.find(23), "\n"
puts
print 'insert(66) = ', tree.insert(66), "\n"
tree.pretty_print
puts
