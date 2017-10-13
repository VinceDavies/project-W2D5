class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    #type of elements
    #use indexes at some point
    #check if it is a nested Array
    #element ^ index power
    #(element + index^2)
    output = 0
    self.flatten.each_index do |i|
      output += 13 + i * self[i]
    end
    output
  end
end

class String
  def hash
    output = 0
    self.chars.each_with_index do |char, i|

      output += char.ord * (i+98123948723)
    end
    output
  end
end



class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    output = 0
    #self is a hash

    self.each do |key,value|
      output += key.hash * value.hash

    end

    output

  end



end
