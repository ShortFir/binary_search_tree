# frozen_string_literal: true

require_relative 'tree'

# Do not use duplicate values because they make it more complicated
# and result in trees that are much harder to balance. Therefore,
# be sure to always remove duplicate values or check for an existing
# value before inserting.

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
# array = Array.new(25) { rand(1..100) }
tree = Tree.new(array)

print "\n#{array.sort.uniq}, length = #{array.sort.uniq.length}\n\n"
tree.pretty_print
puts
print "find(7) = #{tree.find(7)}\n\n"
print "insert(66) = #{tree.insert(66)}\n\n"
tree.pretty_print
puts
print "delete(67) = #{tree.delete(67)}\n\n"
tree.pretty_print
puts
print "delete(66) = #{tree.delete(66)}\n\n"
tree.pretty_print
puts
print "delete(1) = #{tree.delete(1)}\n\n"
tree.pretty_print
puts
print "delete(8) = #{tree.delete(8)}\n\n"
tree.pretty_print
puts
print "Level Order: #{tree.level_order}\n\n"
tree.rebalance
tree.pretty_print
puts
print "Preorder:  #{tree.preorder}\n\n"
print "Inorder:   #{tree.inorder}\n\n"
print "Postorder: #{tree.postorder}\n\n"
print "Depth(6345): #{tree.depth(tree.find(6345))}\n\n"
print "Depth(9):    #{tree.depth(tree.find(9))}\n\n"
print "Depth(4):    #{tree.depth(tree.find(4))}\n\n"
print "Depth(7):    #{tree.depth(tree.find(7))}\n\n"
