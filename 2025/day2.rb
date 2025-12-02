
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

result = 0
lines.each do |range|
  min, max = range.split("-").map(&:to_i)
  
  (min..max).each do |n|
    str = n.to_s
  
    if str.length.even?
      half = str.length / 2
      if str[0...half] == str[half..-1]
        result += n
        puts "#{n} invalid" if @debug
      end
    end
  end
end

puts "result: #{result}"
