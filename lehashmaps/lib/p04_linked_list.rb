class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_accessor :list
  def initialize
    @list = []
  end

  def [](i)
    @list.each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self[0]
  end

  def last
    self[@list.length - 1]
  end

  def empty?
    @list.empty?
  end

  def get(key)
    #this is supposed to return a node by its key
    current_node = last
    while true
      if current_node.key == key
        return current_node.val
      else
        return nil if current_node.prev.nil?
        current_node = current_node.prev
      end
    end
  end

  def include?(key)
    current_node = last #now it is the last node
    while true
      if current_node.key == key
        return true
      elsif current_node.prev.nil?
        return false
      else
        current_node = current_node.prev
      end
    end
  end

  def append(key, val)
    new_node = Node.new(key,val)
    unless empty? #this means its not empty right now
      new_node.prev = last
      last.next = new_node
    end
      @list << new_node


  end

  def update(key, val)
    return nil if empty?
    #find the node with that key, and then update its value
    #start at the tail, if that one doesnt have the right key
    #then you look at the node to its right
    current_node = self.last
    while true
      if current_node.key == key
        current_node.val = val
        break
      else
        break if current_node.prev.nil?
        current_node = current_node.prev
      end
    end
  end

  def remove(key)
    current_node = self.last
    while true
      if current_node.key == key
        unless current_node.next.nil?
          current_node.next.prev = current_node.prev
        end
        unless current_node.prev.nil?
          current_node.prev.next = current_node.next
        end
        current_node = nil
        break
      end

      break if current_node.prev.nil?
      current_node = current_node.prev

    end
  end

  def each
    #this should return an array of the values
    output = []
    current_node = first
    while true
      yield current_node
      # output << current_node
      current_node = current_node.next
      break if current_node.nil?

    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
