# frozen_string_literal: true

require_relative 'node'

# Tree
# rubocop:disable Metrics/ClassLength
class Tree
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
  # Less than, go left...add to left if nothing there
  # more than, right etc...
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

  # 3 cases
  # delete leaf, ie 0 child
  # delete node with 1 child
  # delete node with 2 child
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

  # TODO: Change error return to fit later methods
  def find(value, node = @root)
    return 'Value not found.' if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    end
  end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

  def height(node); end

  def balanced?; end

  def rebalance; end

  # rubocop:disable Style/OptionalBooleanParameter
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  # rubocop:enable Style/OptionalBooleanParameter

  private

  def number_of_children(node)
    if node.left.nil? && node.right.nil?
      0
    elsif !node.left.nil? && !node.right.nil?
      2
    else
      1
    end
  end

  # TODO: Modify find() with this combination?
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def find_parent(node, parent = @root)
    if node.data < parent.data
      if parent.left.data == node.data
        [parent, 'left']
      else
        find_parent(node, parent.left)
      end
    elsif node.data > parent.data
      if parent.right.data == node.data
        [parent, 'right']
      else
        find_parent(node, parent.right)
      end
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def zero_child_delete(node)
    parent, direction = find_parent(node)
    case direction
    when 'left'
      parent.left = nil
    when 'right'
      parent.right = nil
    end
  end

  # rubocop:disable Metrics/AbcSize
  def one_child_delete(node)
    parent, direction = find_parent(node)
    case direction
    when 'left'
      parent.left = (parent.left.left.nil? ? parent.left.right : parent.left.left)
    when 'right'
      parent.right = (parent.right.left.nil? ? parent.right.right : parent.right.left)
    end
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/MethodLength
  def two_child_delete(node)
    next_highest = find_next_highest(node.right)

    one_child_delete(next_highest)

    next_highest.left = node.left
    next_highest.right = node.right

    if node == @root
      @root = next_highest
    else
      parent, direction = find_parent(node)
      case direction
      when 'left'
        parent.left = next_highest
      when 'right'
        parent.right = next_highest
      end
    end
    node.data
  end
  # rubocop:enable Metrics/MethodLength

  def find_next_highest(node)
    return node if node.left.nil?

    find_next_highest(node.left)
  end
end
# rubocop:enable Metrics/ClassLength
