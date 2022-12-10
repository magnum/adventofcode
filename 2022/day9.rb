
require "pry"                        
                                             
moves = File.read('day9.txt').lines
.map{|l| l.split(" ")}
.map {|d,i| [d, i.to_i]}

@rope = Array.new(10) { {x:0,y:0} }
positions1 = []
positions9 = []

def headMove(direction)
  case direction
  when "R" then @rope[0][:x] += 1
  when "L" then @rope[0][:x] -= 1
  when "U" then @rope[0][:y] += 1
  when "D" then @rope[0][:y] -= 1
  end
end


def tailFollow(i)
  line = {
    x: @rope[i-1][:x] - @rope[i][:x], 
    y: @rope[i-1][:y] - @rope[i][:y]
  }
  distance = (line[:x].abs+line[:y].abs).to_f
  return if distance == 0
  line[:x] = (line[:x] / distance).round
  line[:y] = (line[:y] / distance).round
  @rope[i] = {x: @rope[i-1][:x] - line[:x], y: @rope[i-1][:y] - line[:y]}
end


moves.each do |direction, steps|
    steps.times do
      headMove(direction)
      9.times { |i| tailFollow(i+1) }
      positions1.push @rope[1]
      positions9.push @rope[9]
    end
end

result1 = positions1.uniq.length
result2 = positions9.uniq.length
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

