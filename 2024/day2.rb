
require "pry"               

def values_safe?(values)
  direction = values[0] < values[1] ? :up : :down
  values.each_with_index do |value, index|
    next if index == 0
    vprev = values[index-1]
    if (
      (value-vprev).abs > 3 ||
      (direction == :up && value <= vprev) ||
      (direction == :down && value >= vprev) 
    ) 
      return false
    end
  end
  true
end


def parse_lines(lines, allow_one_error: false)
  lines.map do |line|
    values = line.split(" ").map(&:to_i)
    safe = values_safe?(values)
    if(!safe && allow_one_error)
      # try to remove one value from values
      values.each_with_index do |value, index|
        new_values = values.dup
        new_values.delete_at(index)
        safe = values_safe?(new_values)
        if safe
          values = new_values
          break
        end
      end
    end
    {
      values: values,
      safe: safe,
    }
  end
end

lines = File.open("day2.txt").read.split("\n")   
result1 = parse_lines(lines).filter{|l| l[:safe]}.count
result2 = parse_lines(lines, allow_one_error: true).filter{|l| l[:safe]}.count
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

