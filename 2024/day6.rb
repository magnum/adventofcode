
require "pry"                 

def nextObject
  x, y = @pos
  x, y = case @dir
  when "^" 
    [x, y-1]
  when ">" 
    [x+1, y]
  when "v" 
    [x, y+1]
  when "<" 
    [x-1, y]
  end
  @map[y][x] rescue nil
end


def move!
  x, y = @pos
  x, y = case @dir
  when "^" 
    [x, y-1]
  when ">" 
    [x+1, y]
  when "v" 
    [x, y+1]
  when "<" 
    [x-1, y]
  end
  @pos = [x, y]
end

def turn(dir="right")
  case dir
    when "right"
      @dir = @directions[(@directions.index(@dir) + 1) % 4]
  end
end

def info
  puts "#{@pos[0]},#{@pos[1]} dir: #{@dir}, nextObject: #{nextObject}"
end

@directions = ["^", ">", "v", "<"] 
@pos = []
@dir                                            
@map = File.open("day6.test.txt").read
.split("\n").map{|x| x.split("")}  
@map.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    @pos, @dir = [x,y], cell if @directions.index(cell)
  end
end 

positions = []
while nextObject && positions.length < 1000
  info
  x, y = @pos
  positions << @pos unless positions.include?(@pos)
  case nextObject
    when "#" 
      turn("right")
  end
  move!
end
puts "part1: #{positions.length}"

#binding.pry
result1 = nil
result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

