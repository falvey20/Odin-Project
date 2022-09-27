module Enumerable
  
  def my_each_with_index
    idx = 0
    self.my_each do |element|
      yield element, idx
      idx += 1
    end
    return self
  end

  def my_select
    arr = []
    self.my_each do |element|
      if yield element
        arr.push(element)
      end
    end
    return arr
  end

  def my_all?
    self.my_each do |element|
      unless yield element
        return false
      end
    end
    return true
  end

  def my_any?
    self.my_each do |element|
      if yield element
        return true
      end
    end
    return false
  end

  def my_none?
    self.my_each do |element|
      if yield element
        return false
      end
    end
    return true
  end

  def my_count
    if block_given?
      count = 0
      self.my_each do |element|
        if yield element
          count += 1
        end
      end
      return count
    end
    return self.length
  end

  def my_map
    if block_given?
      mapped = []
      self.my_each do |element|
        mapped.push(yield(element))
      end
      return mapped
    end
    return self
  end

  def my_inject(acc=nil, sym=nil)
    if acc && !sym && !block_given?
      acc, sym = nil, acc
    end

    self.my_each do |element|
      if !acc
        acc = element
      elsif sym
        acc = acc.send(sym, element)
      else
        acc = yield acc, element
      end
    end
    acc
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method

class Array
  
  def my_each
    for element in self
      yield element
    end
    return self
  end

end
