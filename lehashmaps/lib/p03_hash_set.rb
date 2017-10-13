require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    return nil if @store[self[key]].include?(key)
    @store[self[key]] << key
    @count += 1
    resize! if @count > @num_buckets
  end

  def include?(key)

    return false unless @store[self[key]].include?(key)
    return true
  end

  def remove(key)
    return nil unless @store[self[key]].include?(key)
    @store[self[key]].delete(key)
    @count -= 1
  end

  private

  def [](key)

    key.hash % @num_buckets
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_array = Array.new(num_buckets * 2) {Array.new}

    @store.flatten.each do |el|
      new_array[ el % (num_buckets * 2 )] << el
    end

    #this new array is going to be the new store
    @store = new_array
    @num_buckets *= 2
  end
end
