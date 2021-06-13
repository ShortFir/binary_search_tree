# frozen_string_literal: true

require_relative 'tree'

# Do not use duplicate values because they make it more complicated
# and result in trees that are much harder to balance. Therefore,
# be sure to always remove duplicate values or check for an existing
# value before inserting.

# Used when initially writing tree.rb
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def testing
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

  print "Height(7): #{tree.height(tree.find(7))}\n\n"
  print "Height(23): #{tree.height(tree.find(23))}\n\n"
  print "Height(3): #{tree.height(tree.find(3))}\n\n"

  print "Balanced?: #{tree.balanced?}\n\n"
  print "delete(3) = #{tree.delete(3)}\n\n"
  print "delete(5) = #{tree.delete(5)}\n\n"
  print "Balanced?: #{tree.balanced?}\n\n"
  tree.pretty_print
  puts
  tree.rebalance
  tree.pretty_print
  puts
  print "Balanced?: #{tree.balanced?}\n\n"
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def print_tree(tree)
  puts
  tree.pretty_print
  puts
end

# Step 12: Testing
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def driver_script
  array = Array.new(25) { rand(1..100) }
  tree = Tree.new(array)
  print_tree(tree)
  print "  Balanced?: #{tree.balanced?}\n\n"
  print "Level Order: #{tree.level_order}\n\n"
  print "   PreOrder: #{tree.preorder}\n\n"
  print "    InOrder: #{tree.inorder}\n\n"
  print "  PostOrder: #{tree.postorder}\n\n"
  print "Insert(330): #{tree.insert(330)}\n\n"
  print "Insert(440): #{tree.insert(440)}\n\n"
  print "Insert(220): #{tree.insert(220)}\n\n"
  print "Insert(110): #{tree.insert(110)}\n\n"
  print_tree(tree)
  print "  Balanced?: #{tree.balanced?}\n\n"
  print "  Rebalance: #{tree.rebalance}\n\n"
  print_tree(tree)
  print "  Balanced?: #{tree.balanced?}\n\n"
  print "Level Order: #{tree.level_order}\n\n"
  print "   PreOrder: #{tree.preorder}\n\n"
  print "    InOrder: #{tree.inorder}\n\n"
  print "  PostOrder: #{tree.postorder}\n\n"
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

driver_script
