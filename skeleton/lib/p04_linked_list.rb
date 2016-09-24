require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end
  #
  # def inspect
  #   puts "key: #{@key} val: #{@val}"
  #   puts "prev/next #{@prev} / #{@next}"
  #   puts "next.key/next.val #{@next.key} / #{@next.val}"
  #   puts "********************************************"
  # end
end

class LinkedList
  include Enumerable

  def initialize(sentinel = LinkedList.make_sentinels)
    @sentinel = sentinel
    @sentinel.prev = @sentinel
  end

  def self.make_sentinels
    sentinel = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    @sentinel.next.nil? && @sentinel.prev == @sentinel
  end

  def get(key)
    return nil unless include? key
    find(key).val
  end

  def include?(key)
    return true unless find(key).nil?
    false
  end

  def insert(key, val)
    new_node = Link.new(key, val)

    if empty?
      @sentinel.next = new_node
      @sentinel.prev = new_node
      new_node.next = @sentinel
      new_node.prev = @sentinel
    else
      old_last = @sentinel.prev
      old_last.next = new_node
      new_node.prev = old_last
      @sentinel.prev = new_node
      new_node.next = @sentinel
    end
  end

  def remove(key)
    return nil unless include? key
    removal = find(key)
    prev_node = removal.prev
    next_node = removal.next
    prev_node.next = next_node
    next_node.prev = prev_node
    removal.next, removal.prev = nil
  end

  def find(key)
    return nil if empty?
    current_node = @sentinel
    while true
      current_node = current_node.next
      return current_node if current_node.key == key
      return nil if current_node == @sentinel
    end
  end

  def each(&prc)
    return nil if empty?
    current_node = first
    until current_node == @sentinel
      prc.call(current_node)
      current_node = current_node.next
    end
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
