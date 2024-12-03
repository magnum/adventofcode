
require "pry"                        
                                             
content = File.open("day3.txt").read

def calculate(operations)
  operations
  .map{|op| op.scan(/\d+/).map(&:to_i)} # extract numbers
  .inject(0){|sum, o| sum + o[0] * o[1]} # multiply each pair of numbers and sum them
end

operations1 = content.scan(/mul\(\d+,\d+\)/)
result1 = calculate(operations1)

operations2 = []
consider = true
content.scan(/don't\(\)|do\(\)|mul\(\d+,\d+\)/).each do |value|
  consider = false if value.index("don't()")
  consider = true if value.index("do()")
  operations2 << value if value.index("mul") && consider
end
result2 = calculate(operations2)
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

