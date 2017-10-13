require 'byebug'


class MaxIntSet

  attr_accessor :store
  def initialize(max)
    @max = max
    @store = Array.new(max){false}
  end

  def insert(num)
    raise ArgumentError.new("out of bounds") if num > @max || num < 0
    @store[num] = true
  end

  def remove(num)
    raise ArgumentError.new("out of bounds") if num > @max || num < 0
    @store[num] = false
  end

  def include?(num)
    raise ArgumentError.new("out of bounds") if num > @max || num < 0
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num % 20] << num
  end

  def remove(num)
    self[num % 20].delete(num)
  end

  def include?(num)
    self[num % 20].include?(num)
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store, :num_buckets

  def initialize(num_buckets = 20, count = 0)
    @store = Array.new(num_buckets) { Array.new }
    @count = count
    @num_buckets = num_buckets
  end

  def insert(num)
    return nil if @store[self[num]].include?(num)
    @store[self[num]] << num
    @count += 1

    resize! if @count > @num_buckets

  end

  def remove(num)
    return nil unless @store[self[num]].include?(num)
    @store[self[num]].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[self[num]].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % @num_buckets
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
