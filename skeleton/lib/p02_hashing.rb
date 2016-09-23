class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 665055 if self.empty?
    x_orer = self.length
    hashed_vals = ''
    self.each do |el|
      if el.is_a?(Array)
        hashed_vals << el.hash
      else
        hashed_vals << (el ^ x_orer).to_s
      end
    end
    hashed_vals.to_i
  end
end

class String
  def hash
    x_orer = self.length
    hashed_string = ''
    self.chars do |char|
      hashed_string << (char.ord ^ x_orer).to_s
    end
    hashed_string.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = []
    hashed = self.to_a.sort_by! do |pair|
      pair[0]
    end
    hashed.map! do |g|
      g.join('').hash
    end
    hashed.map! do |el|
      el.to_s
    end
    hashed = hashed.join('')
    hashed.to_i
  end
end
