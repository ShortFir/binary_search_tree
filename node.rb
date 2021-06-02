# frozen_string_literal: true

# Node, stores data, left & right child
class Node
  # As a bonus, try including the Comparable module and compare nodes using
  # their data attribute.
  include Comparable
  attr_accessor :data, :left_child, :right_child

  # def data; end

  # def left_child; end

  # def right_child; end
end
