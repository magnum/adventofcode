
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
  
  # Part 1
  start_value = value
  operation = direction == "L" ? "-" : "+"
  value = value.send(operation, times) % 100
  password1 += 1 if value == 0
  
  # Part 2
  zeros_during = 0
  (0..times).each do |i|
    pos = (start_value.send(operation, i)) % 100
    zeros_during += 1 if pos == 0
  end
  password2 += zeros_during
  
  puts "#{line} => #{value}" if @debug
end

result1 = password1
result2 = password2
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

