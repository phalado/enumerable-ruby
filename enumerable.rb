module Enumerable
  def my_each(&block)
    if block_given?
      for item in self do
        yield item        
      end      
    else
      self.to_enum      
    end    
  end

  def my_each_with_index(&block)
    unless block_given?
      self.to_enum      
    else
      i = 0
      for item in self do
        yield item, i
        i+=1        
      end
    end
  end

  def my_select(&block)
    unless block_given?
      self.to_enum
    else
      ar = []
      self.my_each do |x|
        if (yield x)
           ar << x         
        end
      end
    end
    return ar
  end

  def my_all?(pattern = false, &block)
    unless block_given?
      unless pattern
        return self.my_all? {|obj| obj}        
      end
      return self.my_all? {|x| x.is_a? pattern }
    else
      self.my_each do |x|
        if !yield x
          return false
        end
      end
      return true
    end    
  end

  def my_any?(&block)
    unless block_given?
      return self.my_any? {|obj| obj}      
    end
    self.my_each do |x|
      return true if yield x;
    end
    return false
  end
  
  def my_none?(&block)
    unless block_given?
      return !self.my_any?
    end
    return !self.my_any? {|x| yield x}    
  end
end