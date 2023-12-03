
require "pry"                        
                                             
lines = File.open("day1.txt").read
.split("\n")   

digits = %w(one two three four five six seven eight nine)
.map.with_index{|k,v| [k,v+1]}.to_h
result1 = lines.map{n = _1.scan(/\d/); "#{n.first}#{n.last}".to_i}.sum
result2 = lines.map do
  lconv = _1.scan(/(?=(#{digits.keys.join("|")}|\d))/)
  .flatten
  .map { |match| digits[match] || match }
  .map(&:to_i)
  "#{lconv.first}#{lconv.last}".to_i
end.sum

puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

