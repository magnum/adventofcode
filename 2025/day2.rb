
require "pry"                 

@debug = ARGV.index("--debug") || false
day = __FILE__.split("/").last.split(".").first.gsub("day","").to_i
filename = "day#{day}.txt"
filename = "day#{day}.test.txt" if ARGV.index("--test")
puts "filename: #{filename} debug: #{@debug}" 

def pause
  STDIN.gets.chomp if @debug
end
                    
input = File.open(filename).read.strip
lines = input.split(",")

result1 = 0
result2 = 0
lines.each do |range|
  min, max = range.split("-").map(&:to_i)
  
  (min..max).each do |n|
    str = n.to_s
    length = str.length
  
    # Part 1
    if length.even?
      half = length / 2
      if str[0...half] == str[half..-1]
        result1 += n
        puts "#{n} invalid (part1)" if @debug
      end
    end
    
    # Part 2
    invalid = false
    (2..length).each do |k|
      next unless length % k == 0
      part_length = length / k
      first_part = str[0...part_length]
      same = true
      (1...k).each do |i|
        part = str[i * part_length...(i + 1) * part_length]
        same = false if part != first_part
      end
      invalid = true if same
    end
    
    result2 += n if invalid
  end
end

puts "part1: #{result1}" if result1
puts "part2: #{result2}" if result2
