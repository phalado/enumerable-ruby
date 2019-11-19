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

  def my_select
    if block_given?
      ar = []
      my_each do |x|
        ar << x if yield x
      end
    else
      to_enum
    end
    ar
  end

  def my_all?(pattern = false)
    if block_given?
      my_each do |x|
        return false unless yield x
      end
      true
    else
      return my_all? { |obj| obj } unless pattern

      my_all? { |x| x.is_a? pattern }
    end
  end

  def my_any?
    return my_any? { |obj| obj } unless block_given?

    my_each do |x|
      return true if yield x
    end
    false
  end

  def my_none?
    return !my_any? unless block_given?

    !my_any? { |x| yield x }
  end

  def my_map(&prc)
    return to_enum unless block_given?

    ar = []
    my_each { |x| ar << (prc ? (yield x) : prc.call(x)) }
    ar
  end

  def my_inject(initial = nil, sym = nil)
    if block_given?
      my_each do |item|
        initial = yield initial, item
      end
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
