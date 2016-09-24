require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return false if bucket(key).find(key).nil?
    true
  end

  def set(key, val)
    @count += 1
    resize! if @count > num_buckets
    bucket(key).remove(key)
    bucket(key).insert(key, val)
  end

  def get(key)
    return nil if bucket(key).find(key).nil?
    bucket(key).find(key).val
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |d|
      p d.to_s
    end
    @store.each do |buck|
      next if buck.empty?
      buck.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    resize_empty = @store
    @store = Array.new(num_buckets * 2) {LinkedList.new}
    resize_empty.each do |buck|
      buck.each do |link|
        bucket(link.key).insert(link.key, link.val)
      end
    end
    @store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
