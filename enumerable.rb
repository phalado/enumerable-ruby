# frozen_string_literal: true

module Enumerable
  def my_each
    if block_given?
      for item in self do
        yield item
      end
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      for item in self do
        yield item, i
        i += 1
      end
    else
      to_enum
    end
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |x| count += 1 if yield x }
    elsif arg
      my_each { |x| count += 1 if x == arg }
    else
      my_each { count += 1 }
    end
    count
  end

  def my_select
    return to_enum unless block_given?

    ar = []
    my_each { |x| ar << x if yield x }
    ar
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |x| return false unless yield x }
    else
      return my_all? { |obj| obj } unless pattern

      if pattern.class == Regexp
        my_each { |x| return false unless pattern.match?(x) }
      elsif pattern.class == Class
        my_each { |x| return false unless x.is_a? pattern }
      else
        my_each { |x| return false unless x === pattern }
      end
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |x| return true if yield x }
    else
      return my_any? { |obj| obj } unless pattern

      if pattern.class == Regexp
        my_each { |x| return true if pattern.match?(x) }
      elsif pattern.class == Class
        my_each { |x| return true if x.is_a? pattern }
      else
        my_each { |x| return true if x === pattern }
      end
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      !my_any? { |x| yield x }
    elsif pattern
      !my_any?(pattern)
    else
      my_each { |x| return false if x }
      true
    end
  end

  def my_map(&prc)
    return to_enum unless block_given?

    ar = []
    my_each { |x| ar << (prc ? (yield x) : prc.call(x)) }
    ar
  end

  def my_inject(initial = nil, sym = nil, &block)
    unless block_given?
      return my_inject_sym(initial) if initial.class == Symbol
      return my_inject_sym(sym, initial) if sym

      raise 'No block nor symbol given'
    end
    return self[1..length].my_inject(self[0], &block) unless initial

    my_each { |x| initial = block.call(initial, x) }
    initial
  end

  def my_inject_sym(sym, initial = nil)
    return self[1..length].my_inject_sym(sym, self[0]) unless initial

    my_each { |x| initial = initial.send sym, x }
    initial
  end

  def multiply_els
    my_inject(1, :*)
  end
end
