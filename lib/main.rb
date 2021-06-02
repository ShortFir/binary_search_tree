# frozen_string_literal: true

require_relative 'tree'

# Do not use duplicate values because they make it more complicated
# and result in trees that are much harder to balance. Therefore,
# be sure to always remove duplicate values or check for an existing
# value before inserting.

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree
print tree.root, "\n"
