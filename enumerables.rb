# rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Lint/Void
p '-----------|||||--------'
p '----------{(o o)}--------'
p '--------ooO-(_)-Ooo------'
# Initial comment
module Enumerable
  def my_each
    return to_enum unless block_given?

    array = to_a
    size.times { |index| yield(array[index]) }
  end

  def my_each_with_index
    return to_enum unless block_given?

    array = to_a
    size.times { |index| yield(array[index], index) }
  end

  def my_select
    return to_enum unless block_given?

    array = to_a
    arraya = []
    array.length.times do |a|
      array[a]
      arraya << array[a] if yield (array[a])
    end
    arraya
  end

  def my_all?(*arg)
    return 'error arguments' if arg.length > 1

    if block_given?
      array = to_a
      cont = 0
      array.length.times do |a|
        array[a]
        if yield (array[a])
          cont += 1
          return true if cont == array.length

          next
        end
        return false
      end
      true elsif arg.empty?
    elsif arg[0].class == Class
      array3 = to_a
      cont2 = 0
      array3.length.times do |b|
        if array3[b].is_a?(arg[0])
          cont2 += 1
          return true if cont2 == array3.length

          next
        end
        return false
      end
    elsif arg[0].class == Regexp
      array3 = to_a
      cont2 = 0
      array3.length.times do |b|
        if arg[0].match(array3[b])
          cont2 += 1
          return true if cont2 == array3.length

          next
        end
        return false
      end
    end
  end
end

module Enumerable
  def my_any?(*arg)
    return 'error arguments' if arg.length > 1

    if block_given?
      array = to_a
      array.length.times do |a|
        array[a]
        return true if yield (array[a])

        return false
      end
      true elsif arg.empty?

    elsif arg[0].class == Class
      array3 = to_a
      array3.length.times do |b|
        return true if array3[b].is_a?(arg[0])

        return false
      end
    elsif arg[0].class == Regexp
      array3 = to_a

      array3.length.times do |b|
        return true if arg[0].match(array3[b])

        return false
      end
    end
  end

  def my_none?(*arg)
    return 'error arguments' if arg.length > 1

    if block_given?
      array = to_a
      cont = 0
      array.length.times do |a|
        array[a]
        if yield (array[a])
          cont += 1
          return false if cont == array.length

          next
        end
        return true
      end
    elsif arg.empty?
      false
    elsif arg[0].class == Class
      array3 = to_a
      cont2 = 0
      array3.length.times do |b|
        if array3[b].is_a?(arg[0])
          cont2 += 1
          return false if cont2 == array3.length

          next
        end
        return true
      end
    elsif arg[0].class == Regexp
      array3 = to_a
      cont2 = 0
      array3.length.times do |b|
        if arg[0].match(array3[b])
          cont2 += 1
          return false if cont2 == array3.length

          next
        end
        return true
      end
    end
  end
end
module Enumerable
  def my_count(*arg)
    return 'error arguments' if arg.length > 1

    cont1 = 0
    array = to_a
    if block_given?
      array.length.times do |a|
        array[a]
        cont1 += 1 if yield (array[a])
        next
      end
      return cont1
    else
      return array.length if arg.empty?

      array.length.times do |a|
        cont1 += 1 if array[a].eql?(arg[0])
        next
      end
    end
    cont1
  end

  def my_map(*arg)
    return 'error arguments' if arg.length > 1

    array = to_a
    array2 = []
    if block_given?

      size.times do |index|
        array2 << yield(array[index])
        array2
      end
    else
      return to_enum if arg.empty?

      arg[0].class == Proc
      size.times do |index|
        array2 << arg[0].call(array[index])
      end
    end
    array2
  end

  def my_inject(number = nil, symbol = nil)
    array = to_a
    acum = 0
    if block_given?
      size.times do |a|
        acum += yield(acum, array[a])
      end
      return acum if number.nil?

      acum + number
    else
      !number.nil? && symbol.nil?
      if number.class == Integer
        acum = number
        size.times do |x|
          acum += array[x]
        end
        acum
      elsif number.class == Float
        acum = number
        size.times do |x|
          acum += array[x]
        end
        acum
      elsif number.class == Symbol || number.class == String
        accumulator = nil
        my_each { |index| accumulator = accumulator.nil? ? index : accumulator.send(number, index) }
        accumulator
      end
    end
  end
end
def multiply_els(array)
  array.my_inject(:*)
end

puts '****Enumerables*******'
puts
puts '=======my_each======='

[1, 2, 3, 'ewerw'].my_each { |x| print x.to_s + ' ' }
puts

puts '========my_each_with_index========'

[1, 2, 3, 'ewerw'].my_each_with_index { |x, y| print x, " index #{y}", puts }
puts
puts
puts '=======my_select======='
p [2, 2, 3, 4].my_select(&:even?)
p(%w[carlos paul maria diana].my_select { |x| x != 'paul' })
p(%w[carlos paul maria diana].my_select { |x| x == 'maria' })
puts
puts
puts '===========my_all?=========='
puts 'my_all without argument'
p [2, 4, 6, 8, 0].my_all?
puts 'my_all with a class argument'
p [2, 4, 6, 8.7, 0].my_all?(Integer)
p [2, 4, 6, 8, 0].my_all?(Integer)
puts 'my_all with a Regex argument'
p %w[all art afk arg abs].my_all?(/a/)
p %w[bazooca bob moon sun fagds].my_all?(/b/)
puts 'my_all with Block'
p [2, 4, 6, 8, 0].my_all?(&:even?)
p(['sa', 'sdfsd', 'fr', 0].my_all? { |x| x.is_a? String })
puts
puts
puts '===========my_any?============'
puts 'my_any? without argument'
p [2, 4, 6, 8, 0].my_any?
puts 'my_any? with a class argument'
p [2, 4, 6, 8.7, 0].my_any?(String)
p [2, 4, 6, 8, 0].my_any?(Integer)
puts 'my_any? with a Regex argument'
p %w[all art afk arg abs].my_any?(/z/)
p %w[bazooca bob moon sun fagds].my_any?(/b/)
puts 'my_any? with Block'
p [2, 4, 6, 8, 0].my_any?(&:odd?)
p(['sa', 'sdfsd', 'fr', 0].my_any? { |x| x.is_a? String })
puts
puts
puts '============my_none?=========='
puts 'my_none without argument'
p [2, 4, 6, 8, 0].my_none?
puts 'my_none with a class argument'
p [2, 4, 6, 8.7, 0].my_none?(String)
p [2, 4, 6, 8, 0].my_none?(Integer)
puts 'my_none with a Regex argument'
p %w[all art afk arg abs].my_none?(/z/)
p %w[bazooca bob moon sun fagds].my_none?(/b/)
puts 'my_none with Block'
p [2, 4, 6, 8, 0].my_none?(&:odd?)
p(['sa', 'sdfsd', 'fr', 0].my_none? { |x| x.is_a? Hash })
puts
puts
puts '============my_count=========='
puts 'my_count without argument'
p [9, 4, 6, 0].my_count
puts 'my_count with argument'
p [9, 4, 6, 0].my_count(6)
p ['str', 4, 6, 0, 'str'].my_count('str')
puts 'my_count with a Block'
p([2, 0, 6, 8, 678].my_count { |x| x == 2 })
p([2, 0, 'DF', 8, 6.78].my_count { |x| x.is_a? Integer })
puts
puts
puts '============my_map=========='
puts 'my_map with a Block'
p([1, 2, 3].my_map { |x| x + 2 })
puts 'my_map with a proc'
proc1 = proc { |x| x.is_a? String }
p [1, 2, 'sdgfsdfg'].my_map(proc1)
puts
puts
puts '============my_inject=========='
puts 'my_inject just with a Block'
p([2, 4, 7, 8].my_inject { |ac, n| ac + n })
puts 'my_inject just with a Block and a argument'
p [2, 4, 7, 8].my_inject(25) { |ac, n| ac + n }
puts 'my_inject just with a number as argument'
p [2, 4, 7, 8].my_inject(25)
p [2, 4, 7, 8].my_inject(25.78)
puts 'my_inject just with a symbol as argument'
p [2, 4, 7, 8].my_inject(:*)
puts 'my_inject just with a string as argument'
p [2, 4, 7, 8].my_inject('+')
puts 'multiply_els method test'
p multiply_els([2, 4, 5])
p '------------------------'

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Lint/Void
