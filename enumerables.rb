p '-----------|||||--------'
p '----------{(o o)}--------'
p '--------ooO-(_)-Ooo------'

module Enumerables
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
    array_2 = []
    array.length.times do |a|
      array[a]
      if yield (array[a])
        array_2 << array[a]
      end
    end
    array_2  
  end

  def my_all?(*arg)  
    return "error arguments" if arg.length > 1

    if block_given?
      array = to_a
      cont = 0
      array.length.times do |a|
        array[a]
        if yield (array[a])
          cont += 1
          if cont==array.length
            return true   
          end
          next
        end
        return false
      end
    elsif arg.empty?
     return true
    elsif  arg[0].class == Class
      array_3 = to_a 
      cont_2 = 0
      array_3.length.times do |b|
        if array_3[b].is_a?(arg[0])
          cont_2 += 1
          if cont_2==array_3.length
            return true
          end
          next    
        end
        return false
      end
    elsif arg[0].class == Regexp
      array_3 = to_a     
      cont_2 = 0
      array_3.length.times do |b|
        if arg[0].match(array_3[b])
          cont_2 += 1
          if cont_2 == array_3.length
            return true
          end
          next   
        end
        return false
      end
   
    end  
    
  end
end 
module Enumerables 
  def my_any?(*arg)
    
    return "error arguments" if arg.length > 1
    if block_given?
      array = to_a     
      array.length.times do |a|
        array[a]
        if yield (array[a])           
          return true   
        end
        return false
      end
    elsif arg.empty?
     return true 
    elsif  arg[0].class == Class
      array_3 = to_a       
      
      array_3.length.times do |b|
        if array_3[b].is_a?(arg[0])             
          return true        
        end
        return false
      end
    elsif arg[0].class == Regexp   
      array_3 = to_a       
      
      array_3.length.times do |b|
        if arg[0].match(array_3[b])  
          return true         
        end
        return false
      end  
    end     
  end

  def my_none? (*arg)
    
    return "error arguments" if arg.length > 1
    if block_given?
      array = to_a  
      array2 = []      
      cont = 0
      array.length.times do |a|
        array[a]
        if yield (array[a])
          cont += 1
          if cont == array.length
            return false   
          end
          next
        end
        return true
      end
    elsif arg.empty?
     return false
    elsif  arg[0].class == Class
      array_3 = to_a       
      cont_2 = 0
      array_3.length.times do |b|
        if array_3[b].is_a?(arg[0])
          cont_2 += 1
          if cont_2 == array_3.length
            return false
          end
          next          
        end
        return true
      end
    elsif arg[0].class == Regexp   
      array_3 = to_a       
      cont_2 = 0
      array_3.length.times do |b|
        if arg[0].match(array_3[b])
          cont_2 += 1
          if cont_2 == array_3.length
            return false
          end
          next          
        end
        return true
      end
    end 
  end
end
module Enumerables  
  def my_count(*arg)

    return "error arguments" if arg.length > 1
    cont_1 = 0 
    array = to_a 
    if block_given?       
      array.length.times do |a|
        array[a]
        if yield (array[a])
          cont_1 += 1                    
        end
        next
      end
      return cont_1
    else 
      if arg.empty?
        return array.length
      else 
        array.length.times do |a|
          if array[a].eql?(arg[0])
            cont_1 += 1
          end 
          next 
        end
        return cont_1  
      end 
    end  
  end
  def my_map(*arg)
    
    return "error arguments" if arg.length > 1
    array = to_a
    array_2 = []
    if block_given?
           
      size.times do |index| 
      array_2 << yield(array[index]) 
      array_2
      end
      return array_2
    else
      if arg.empty? 
        return to_enum 
      else arg[0].class == Proc
        
        size.times do |index|
          array_2 << arg[0].call(array[index]) 
        end
        return array_2  
      end  
    end       
  end
  def my_inject(number=nil, symbol=nil)  
    array = to_a
    array_2 = []
    acum = 0
    if block_given?
      
      if number.nil?       
        size.times do |a|
          acum+=yield(acum,array[a])
        end
        return acum
      else 
        
        size.times do |a|
          acum += yield(acum,array[a])
        end
        return acum + number
      end

    else
      if !number.nil? && symbol.nil?
        if number.class == Integer
          acum=number
          size.times do |x|
            acum += array[x]
          end
          return acum
        elsif number.class == Float
          acum = number
          size.times do |x|
            acum += array[x]
          end
          return acum   
        elsif number.class == Symbol || number.class == String 
          accumulator = nil
          my_each { |index| accumulator = accumulator.nil? ? index : accumulator.send(number, index) }
          accumulator  
        end       
      end      
    end     
  end
end 
def multiply_els(array)
  array.my_inject(:*)
end 
include Enumerables
puts "****Enumerables*******"
puts  
puts "=======my_each======="

[1,2,3,"ewerw"].my_each{|x| print x.to_s + " "}
puts

puts "========my_each_with_index========"

[1,2,3,"ewerw"].my_each_with_index{|x,y| print x , " index #{y}" ,puts}
puts
puts
puts "=======my_select======="
p [2,2,3,4].my_select{|x|  x.even?  }
p ["carlos","paul","maria","diana"].my_select{|x|  x!="paul"  }
p ["carlos","paul","maria","diana"].my_select{|x|  x=="maria"  }
puts
puts
puts "===========my_all?=========="
puts "my_all without argument"
p [2,4,6,8,0].my_all?
puts "my_all with a class argument"
p [2,4,6,8.7,0].my_all?(Integer)
p [2,4,6,8,0].my_all?(Integer)
puts "my_all with a Regex argument"
p ["all","art","afk","arg","abs"].my_all?(/a/)
p ["bazooca","bob","moon","sun","fagds"].my_all?(/b/)
puts "my_all with Block"
p [2,4,6,8,0].my_all?{|x|  x.even? }
p ["sa","sdfsd","fr",0].my_all?{|x|  x.is_a? String }
puts
puts
puts "===========my_any?============"
puts "my_any? without argument"
p [2,4,6,8,0].my_any?
puts "my_any? with a class argument"
p [2,4,6,8.7,0].my_any?(String)
p [2,4,6,8,0].my_any?(Integer)
puts "my_any? with a Regex argument"
p ["all","art","afk","arg","abs"].my_any?(/z/)
p ["bazooca","bob","moon","sun","fagds"].my_any?(/b/)
puts "my_any? with Block"
p [2,4,6,8,0].my_any?{|x|  x.odd? }
p ["sa","sdfsd","fr",0].my_any?{|x|  x.is_a? String }
puts
puts
puts "============my_none?=========="
puts "my_none without argument"
p [2,4,6,8,0].my_none?
puts "my_none with a class argument"
p [2,4,6,8.7,0].my_none?(String)
p [2,4,6,8,0].my_none?(Integer)
puts "my_none with a Regex argument"
p ["all","art","afk","arg","abs"].my_none?(/z/)
p ["bazooca","bob","moon","sun","fagds"].my_none?(/b/)
puts "my_none with Block"
p [2,4,6,8,0].my_none?{|x|  x.odd? }
p ["sa","sdfsd","fr",0].my_none?{|x|  x.is_a? Hash }
puts
puts
puts "============my_count=========="
puts "my_count without argument"
p [9,4,6,0].my_count
puts "my_count with argument"
p [9,4,6,0].my_count(6)
p ["str",4,6,0,"str"].my_count("str")
puts "my_count with a Block"
p [2,0,6,8,678].my_count{|x| x == 2}
p [2,0,"DF",8,6.78].my_count{|x| x.is_a? Integer}
puts
puts
puts "============my_map=========="
puts "my_map with a Block"
p [1,2,3].my_map{|x| x+2}
puts "my_map with a proc"
proc_1 = Proc.new {|x| x.is_a? String}
p [1,2,"sdgfsdfg"].my_map(proc_1)
puts
puts
puts "============my_inject=========="
puts "my_inject just with a Block"
p [2,4,7,8].my_inject{|ac,n| ac+n}
puts "my_inject just with a Block and a argument"
p [2,4,7,8].my_inject(25){|ac,n| ac+n}
puts "my_inject just with a number as argument"
p [2,4,7,8].my_inject(25)
p [2,4,7,8].my_inject(25.78)
puts "my_inject just with a symbol as argument"
p [2,4,7,8].my_inject(:*)
puts "my_inject just with a string as argument"
p [2,4,7,8].my_inject("+")
puts "multiply_els method test"
p multiply_els([2,4,5])
p'------------------------'















