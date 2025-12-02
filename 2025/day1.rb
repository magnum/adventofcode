
require "pry"                 

@debug = ARGV.index("--debug") || false
day = __FILE__.split("/").last.split(".").first.gsub("day","").to_i
filename = "day#{day}.txt"
filename = "day#{day}.test.txt" if ARGV.index("--test")
puts "filename: #{filename} debug: #{@debug}" 

def pause
  STDIN.gets.chomp if @debug
end
                    
lines = File.open(filename).read
.split("\n")   
value = 50
password1 = 0
password2 = 0
lines.each do |line|
  chars = line.chars
  direction = chars.shift
  times = chars.join.to_i
  operation = direction == "L" ? "-" : "+"
  value2 = value
  value = value.send(operation, times) % 100
  password1 += 1 if value == 0
  password2 += 1 if value == 0 
  puts "#{line} => #{value}"
  password2 += (value.send(operation, times) / 100).abs
end


result1 = password1
result2 = password2
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

