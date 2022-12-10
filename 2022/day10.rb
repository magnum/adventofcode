require 'pry'

def parseRows
  x, cycle = 1, 0
  cycles = []
  File.open("day10.txt").read.split("\n").each do |line|
    command, param1 = line.split(" ")
    case command
    when "noop"
      cycles << yield(x, cycle)
      cycle += 1
    when "addx"
      2.times do
        cycles << yield(x, cycle)
        cycle += 1
      end
      x += param1.to_i
    end
  end
  cycles
end

result1 = parseRows do |x, cycle|
  [20, 60, 100, 140, 180, 220].include?(cycle + 1) ? (x * (cycle + 1)) : 0 
end.sum
puts result1

screen_size = 40
result2 = parseRows do |x, pos|
  [x - 1, x, x + 1].include?(pos % screen_size) ? "#" : " "
end.each_slice(screen_size).map { |row| row.join }.join("\n")
puts result2