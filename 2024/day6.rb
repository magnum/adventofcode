
require "pry"                 

@debug = ARGV.index("--debug") || false
day = __FILE__.split("/").last.split(".").first.gsub("day","").to_i
filename = "day#{day}.txt"
filename = "day#{day}.test.txt" if ARGV.index("--test")
puts "filename: #{filename} debug: #{@debug}" 

def pause
  STDIN.gets.chomp if @debug
end


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
  # return nil if out of bounds
  return nil if x < 0 || y < 0 || x >= @map[0].length || y >= @map.length
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
  @map[y][x] = "X"
  @pos = [x, y]
  savePosition
end

def savePosition
  @positions << @pos unless @positions.include?(@pos)
  showMap if @debug
  pause
end

def turn(dir="right")
  case dir
    when "right"
      @dir = @directions[(@directions.index(@dir) + 1) % 4]
  end
end

def info
  puts "#{@positions.length} #{@pos[0]},#{@pos[1]} dir: #{@dir}, nextObject: #{nextObject}"
end


def showMap
  puts @map.map{|x| x.join("")}.join("\n")
end

@directions = ["^", ">", "v", "<"] 
@positions = []
@pos = []
@dir                                            
@map = File.open(filename).read
.split("\n").map{|x| x.split("")}  
@map.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    @pos, @dir = [x,y], cell if @directions.index(cell)
  end
end 
@map[@pos[1]][@pos[0]] = "X"


while nextObject && @positions.length < 100000
  info
  x, y = @pos
  case nextObject
    when "#" 
      turn("right")
    when "X"
      move!
    when "."
      move!
  end
  
end

#binding.pry
result1 = @positions.length
result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

