
require "pry"                        
                                             
lines = File.open("day3.txt").read
.split("\n")   

lines.each_with_index do |line,indexl|
  numbers = []
  line.each_char.with_index do |c, indexc|
    numbers << "" if (indexc == 0 || line.chars[indexc-1] == "." rescue false)
    numbers[numbers.size-1] += c if c =~ /[0-9]/
  end
  numbers.filter!{ _1 != ""}
  puts "line#{indexl}, numbers: #{numbers}"
end

result1 = nil
result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

