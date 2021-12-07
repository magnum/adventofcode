require 'pry'

lines = open('7.txt') {|f| f.read }.split("\n")


positions = lines[0].split(",").map(&:to_i)
cost_min = ((positions.length * positions.max).times).sum
puts "positions.max: #{positions.max}, positions.length: #{positions.length}"
positions.length.times do |i|
    cost = positions.inject(0){|cost, p| cost+((p-i).abs)+((p-i).abs.times).sum}
    if cost <= cost_min
        cost_min = cost
        puts "#{i}, cost: #{cost}" 
    end
end

