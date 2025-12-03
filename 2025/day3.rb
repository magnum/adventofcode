
require "pry"                 

@debug = ARGV.index("--debug") || false
day = __FILE__.split("/").last.split(".").first.gsub("day","").to_i
filename = "day#{day}.txt"
filename = "day#{day}.test.txt" if ARGV.index("--test")
puts "filename: #{filename} debug: #{@debug}" 

def pause
  STDIN.gets.chomp if @debug
end
         
result1 = 0
lines = File.open(filename).read 
.split("\n")
.each_with_index do |line|
  b1, index1 = line.chars.map(&:to_i)[0..-2].each_with_index.max
  remaining = line[(index1+1)..]
  b2, index2 = remaining.chars.map(&:to_i)[0..].each_with_index.max
  puts "b1: #{b1}, index1: #{index1}, remaining: #{remaining}, b2: #{b2}, index2: #{index2}"
  result1 += "#{b1}#{b2}".to_i
end
#binding.pry

result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

