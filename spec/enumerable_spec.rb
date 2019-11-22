#spec/enumerable_spec.rb

require './enumerable.rb'

RSpec.describe Enumerable do
  describe "#my_all?" do
    it "Return true if all the words on the array have 3 letters or more" do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be_truthy
    end

    it "Return true if all the words on the array have 4 letters or more" do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to be_falsy
    end

    it "Return true if all the words on the array have the letter 't' on it" do
      expect(%w[ant bear cat].my_all?(/t/)).to be_falsy
    end

    it "Return true if all the words on the array start with 'T'" do
      expect(%w[Tia Tib Tic].my_all?(/T\w+/)).to be_truthy
    end

    it "Return true if all the elements on the array are numeric" do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be_truthy
    end

    it "Return true if all the elements on the array return true" do
      expect([nil, true, 99].my_all?).to be_falsy
    end

    it "Return true if you have an empty array and no block" do
      expect([].my_all?).to be_truthy
    end

    it "Return true if you have an empty array and any block" do
      expect([].my_all? { |x| x == 8273 }).to be_truthy
    end

    it "Return true if all the elements on the array are numeric" do
      expect([5, 5, 5].my_all?(5)).to be_truthy
    end

    it 'Return true if all element of range match' do
      expect((1..2).my_all? { |x| x >= 1 }).to be_truthy
    end
  end

  describe '#my_any?' do
    it "Return true if any of the words on the arrays has a length greater or equal 3" do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to be_truthy
    end

    it "Return true if any of the words on the arrays has a length greater or equal 5" do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to be_falsy
    end

    it "Return true if any of the words on the arrays has a 'd'" do
      expect(%w[ant bear cat].my_any?(/d/)).to be_falsy
    end

    it "Return true if any of the words on the arrays has a 'r'" do
      expect(%w[ant bear cat].my_any?(/r/)).to be_truthy
    end

    it "Return true if any of the elements of the arrays is an Integer" do
      expect([nil, true, 99].my_any?(Integer)).to be_truthy
    end

    it "Return true if there is no block and array is not empty" do
      expect([nil, false, 99].my_any?).to be_truthy
    end

    it "Return false if there is no block and array is empty" do
      expect([].my_any?).to be_falsy
    end

    it "Return true if there is no any element in the array thar match the element" do
      expect([5, 6, 7].my_any?(5)).to be_truthy
    end

    it 'Return true if all element of range match' do
      expect((1..2).my_any? { |x| x > 1 }).to be_truthy
    end
  end

  describe '#my_none?' do
    it "Return true if there is no block and the array is empty" do
      expect([].my_none?).to be_truthy
    end

    it "Return true if you have an empty array and any block" do
      expect([].my_none? { |x| x == 8273 }).to be_truthy
    end

    it "Return true if no element of array match block" do
      expect([5, 6, 7, 8].my_none? { |x| x < 5 }).to be_truthy
    end

    it "Return true if no element of array match block" do
      expect(%w[a b b].my_none? { |x| x.eql?('a') }).to be_falsy
    end

    it 'Return false if any element of range match' do
      expect((1..2).my_none? { |x| x > 1 }).to be_falsy
    end
  end
end


# it "" do
#       expect().to output().to_stdout
#     end