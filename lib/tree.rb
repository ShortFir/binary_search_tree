# frozen_string_literal: true

require_relative 'node'

# Tree
class Tree
  # As a bonus, try including the Comparable module and compare nodes using
  # their data attribute.
  include Comparable
  attr_reader :root

  def initialize(array)
    array.sort!.uniq!
    @root = build_tree(array, 0, array.length - 1)
  end

  # Algorithm
  # 1. Initialize start=0, end=length of array-1
  # 2. mid=(start+end/2)
  # 3. Create a tree node with mid as root(lets call it A)
  # 4. Recursively do following steps, 5 & 6
  # 5. Calculate mid of left subarray and make it root of left subtree of A
  # 6. Calculate mid of right subarray and make it root of right subtree of A
  def build_tree(array, start, a_end)
    return nil if start > a_end

    mid = (start + a_end) / 2
    node = Node.new(array[mid])
    node.left = build_tree(array, start, mid - 1)
    node.right = build_tree(array, mid + 1, a_end)
    node
  end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

  def height(node); end

  def balanced?; end

  def rebalance; end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
