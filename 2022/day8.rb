
require "pry"                        

map = [];                                             
lines = File.open("day8.txt").read
.split("\n")   
.each_with_index do |line, x|
  map[x] = [] unless map[x]
  line.chars.each_with_index do |h, y|
    map[x][y] = h.to_i
  end
end


def parse_map(map)
  map_width = map[0].size
  map_height = map.map{|row| row[0]}.size
  map.each_with_index do |row, y|
    row.each_with_index do |h, x|
      trees_left= []
      trees_right = []
      trees_top = []
      trees_bottom = []
      col = map.map{|y| row[x]}
      is_top = false
      if y == 0 || y == map_height-1 # top and bottom lines
        is_top = true
      elsif (x == 0 || x == map_width-1) # left and right lines
        is_top = true
      else 
        trees_left= map[y][0..x-1]
        trees_right = map[y][x+1..map_width-1] 
        trees_top = map.map{|line| line[x]}.map.with_index{|h, _y| (_y<y ) ? h : nil }.compact
        trees_bottom = map.map{|line| line[x]}.map.with_index{|h, _y| (_y>y) ? h : nil }.compact
        is_top = true if (trees_left.max < h || trees_right.max < h || trees_top.max < h || trees_bottom.max < h)
        #puts "#{x}:#{y} h: #{h}, is_top: #{is_top}"
      end
      yield x, y, h, trees_left, trees_right, trees_top, trees_bottom, is_top
    end
  end
end

trees_visible = []
parse_map(map) do |x, y, h, trees_left, trees_right, trees_top, trees_bottom, is_top|
  trees_visible << [y,x] if is_top
end

def calculate_score(h, others)
  score = 0
  previous = 0
  others.each do |i|
    score += 1
    break if i >= h
  end
  score
end

scenic_scores = []
parse_map(map) do |x, y, h, trees_left, trees_right, trees_top, trees_bottom, is_top|
  st = calculate_score(h, trees_top.reverse) 
  sl = calculate_score(h, trees_left.reverse)
  sb = calculate_score(h, trees_bottom)
  sr = calculate_score(h, trees_right)
  score = sl * sr * st * sb
  #puts "x: #{x}, y: #{y}, h: #{h}, score: #{score}, st: #{st}, sl: #{sl},  sb: #{sb}, sr: #{sr}"
  scenic_scores << {x: x, y: y, score: score}
end
#binding.pry
result1 = trees_visible.count
result2 = scenic_scores.map{|t| t[:score]}.max
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

