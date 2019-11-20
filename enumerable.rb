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
    unless block_given?
      return my_all? { |obj| obj } unless pattern

      if pattern.class == Regexp
        my_all? { |x| pattern.match(x) }
      elsif pattern.class == Class
        my_all? { |x| x.is_a? pattern }
      else
        my_all? { |x| x === pattern }
      end
    end
    my_each { |x| return false unless yield x }
    true
  end

  def my_any?(pattern = nil)
    unless block_given?
      return my_any? { |obj| obj } unless pattern

      if pattern.class == Regexp
        my_any? { |x| pattern.match(x) }
      elsif pattern.class == Class
        my_any? { |x| x.is_a? pattern }
      else
        my_any? { |x| x === pattern }
      end
    end
    my_each { |x| return true if yield x }
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

  def my_inject(initial = nil, sym = nil)
    if block_given?
      my_each { |item| initial = yield initial, item }
    else
      unless sym
        raise 'No symbol nor block given' unless initial.class == Symbol

        sym = initial
        initial = self[0]
      end
      my_each do |item|
        next if initial == item

        initial = initial.send sym, item
      end
    end
    initial
  end

  def multiply_els
    my_inject(1, :*)
  end
end
