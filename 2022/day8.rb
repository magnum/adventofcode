
require "pry"                        

map = [];                                             
lines = File.open("day8.txt").read.split("\n")   
.each_with_index do |line, x|
  map[x] = [] unless map[x]
  line.chars.each_with_index{|h, y| map[x][y] = h.to_i}
end


def score!(h, others)
  score = 0
  previous = 0
  others.each do |i|
    score += 1
    break if i >= h
  end
  score
end


def parse_map(map)
  map_width = map[0].size
  map_height = map.map{|row| row[0]}.size
  map.each_with_index do |row, y|
    row.each_with_index do |h, x|
      col = map.map{|y| row[x]}
      lefts= map[y][0..x-1]
      rights = map[y][x+1..map_width-1] 
      tops = map.map{|line| line[x]}.map.with_index{|h, i| (i < y ) ? h : nil }.compact
      bottoms = map.map{|line| line[x]}.map.with_index{|h, i| (i > y) ? h : nil }.compact
      is_top = false
      if  (y == 0 || y == map_height-1) || (x == 0 || x == map_width-1) # perimeter
          is_top = true
      else 
        is_top = true if (lefts.max < h || rights.max < h || tops.max < h || bottoms.max < h)
      end
      yield x, y, h, lefts, rights, tops, bottoms, is_top
    end
  end
end

trees_visible = []
parse_map(map) do |x, y, h, lefts, rights, tops, bottoms, is_top|
  trees_visible << [y,x] if is_top
end


scores = []
parse_map(map) do |x, y, h, lefts, rights, tops, bottoms, is_top|
  scores << score!(h, tops.reverse) * score!(h, lefts.reverse) * score!(h, bottoms) * score!(h, rights)
end

result1 = trees_visible.count
result2 = scores.max
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

