# frozen_string_literal: true

# Node, stores data, left & right child
class Node
  # As a bonus, try including the Comparable module and compare nodes using
  # their data attribute.
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end

  def inspect
    @data
  end
end
