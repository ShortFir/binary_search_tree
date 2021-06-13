# frozen_string_literal: true

require_relative 'node'
require_relative 'module/delete'

# Tree
# rubocop:disable Metrics/ClassLength
class Tree
  include Delete
  attr_reader :root

  def initialize(array)
    array.sort!.uniq!
    @root = build_tree(array)
  end

  # Algorithm
  # 1. Initialize start=0, end=length of array-1
  # 2. mid=(start+end/2)
  # 3. Create a tree node with mid as root(lets call it A)
  # 4. Recursively do following steps, 5 & 6
  # 5. Calculate mid of left subarray and make it root of left subtree of A
  # 6. Calculate mid of right subarray and make it root of right subtree of A
  def build_tree(array, start = 0, array_end = array.length - 1)
    return nil if start > array_end

    middle = (start + array_end) / 2
    node = Node.new(array[middle])
    node.left = build_tree(array, start, middle - 1)
    node.right = build_tree(array, middle + 1, array_end)
    node
  end

  # Only add as leaf
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity
  def insert(value, node = @root)
    return 'Value already exists.' if node.data == value

    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    elsif value > node.data
      if node.right.nil?
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity

  # Requires module 'Delete'
  def delete(value)
    node = find(value)
    return node if node.is_a?(String)

    case number_of_children(node)
    when 0 then zero_child_delete(node)
    when 1 then one_child_delete(node)
    when 2 then two_child_delete(node)
    end
    node.data
  end

  # TODO: Change error return?
  def find(value, node = @root)
    return 'Value not found.' if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order
    queue = level_order_recursion
    # queue = level_order_iteration
    queue.each_with_object([]) { |node, array| array << node.data }
  end

  # Recursion
  def level_order_recursion(queue = [@root], index = 0)
    return if queue[index].nil?

    queue << queue[index].left unless queue[index].left.nil?
    queue << queue[index].right unless queue[index].right.nil?
    level_order_recursion(queue, index + 1)
    queue
  end

  # Iteration
  def level_order_iteration(queue = [@root], index = 0)
    until queue[index].nil?
      queue << queue[index].left unless queue[index].left.nil?
      queue << queue[index].right unless queue[index].right.nil?
      index += 1
    end
    queue
  end

  # <root><left><right>
  def preorder(node = @root, queue = [])
    return if node.nil?

    queue << node.data
    preorder(node.left, queue)
    preorder(node.right, queue)
    queue
  end

  # <left><root><right>
  def inorder(node = @root, queue = [])
    return if node.nil?

    inorder(node.left, queue)
    queue << node.data
    inorder(node.right, queue)
    queue
  end

  # <left><right><root>
  def postorder(node = @root, queue = [])
    return if node.nil?

    postorder(node.left, queue)
    postorder(node.right, queue)
    queue << node.data
    queue
  end

  def height(node)
    _count, max = height_rec(node)
    max
  end

  def depth(depth_node, node = @root, count = 0)
    return count if depth_node == node

    if depth_node.data < node.data
      depth(depth_node, node.left, count + 1)
    else
      depth(depth_node, node.right, count + 1)
    end
  end

  def balanced?
    left = height(@root.left)
    right = height(@root.right)
    left.between?(right - 1, right + 1)
  end

  def rebalance
    array = level_order
    array.sort!.uniq!
    @root = build_tree(array)
  end

  # rubocop:disable Style/OptionalBooleanParameter
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  # rubocop:enable Style/OptionalBooleanParameter

  private

  # rubocop:disable Metrics/MethodLength
  def height_rec(node, count = 0, max = 0)
    if node.left.nil?
      max = count if max < count
    else
      count, max = height_rec(node.left, count + 1, max)
    end
    if node.right.nil?
      max = count if max < count
    else
      count, max = height_rec(node.right, count + 1, max)
    end
    [count - 1, max]
  end
  # rubocop:enable Metrics/MethodLength
end
# rubocop:enable Metrics/ClassLength
