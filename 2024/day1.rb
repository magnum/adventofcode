
require "pry"                      
list1, list2 = [], []                                 
lines = File.open("day1.txt").read
.split("\n")   
.each do |line| 
  a,b = line.split(" ").map(&:strip).map(&:to_i)
  list1 << a
  list2 << b
end
#part1
difs = []    
list1.sort.each_with_index do |a, index|
  b = list2.sort[index]
  difs << (b - a).abs
end
#part2
counts = []
list1.each do |a|
  counts << a*list2.count(a)
end
#binding.pry
result1 = difs.sum
result2 = counts.sum
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

