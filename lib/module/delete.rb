# frozen_string_literal: true

# Delete
module Delete
  def number_of_children(node)
    if node.left.nil? && node.right.nil?
      0
    elsif !node.left.nil? && !node.right.nil?
      2
    else
      1
    end
  end

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

    case number_of_children(next_highest)
    when 0
      zero_child_delete(next_highest)
    when 1
      one_child_delete(next_highest)
    end

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
