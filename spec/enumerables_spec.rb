require_relative '../enumerables.rb'

describe Enumerable do
  str_array = ['Javascript', 'React', 'Node', 'RubyOnRails']
  str_upcase = ['JAVASCRIPT', 'REACT', 'NODE', 'RUBYONRAILS']
  element_array = ['React']
  element_range = [5]
  range = (1..9)
  array2 = [6,7,8,9]
  describe '#my_each' do
    it 'Should return the same array' do
        expect(str_array.my_each{|x| x}).to eql(str_array)
    end    
  end
  describe '#my_each' do
    it 'Should return the same range' do
        expect(range.my_each{|x| x}).to eql(range)
    end    
  end
  describe '#my_each_with_index' do
    it 'Should return the same array' do
        expect(str_array.my_each_with_index{|x| x}).to eql(str_array)
    end    
  end
  describe '#my_each_with_index' do
    it 'Should return the same range' do
        expect(range.my_each_with_index{|x| x}).to eql(range)
    end    
  end
  describe '#my_select' do
    it 'Should return the select element of the array' do
        expect(str_array.my_select{|x| x == 'React'}).to eql(element_array)
    end    
  end
  describe '#my_select' do
    it 'Should return the select element of the range' do
        expect(range.my_select{|x| x == 5}).to eql(element_range)
    end    
  end
  describe '#my_select' do
    it 'Should return the select element of the range' do
        expect(range.my_select{|x| x > 5}).to eql(array2)
    end    
  end
end  