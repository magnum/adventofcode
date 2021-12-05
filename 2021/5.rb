require 'pry'

lines = open('5.txt') {|f| f.read }
.split("\n")

def set_point(x,y)
  key = "#{x}_#{y}"
  @points[key] = @points[key] ? @points[key]+1 : 1
end

@points = {}
lines.each_with_index do |line, i|
  from, to = line.split("->").map(&:strip).map{|p| x,y=p.split(",").map(&:to_i)}
  isOrtogonal = from[0] == to[0] || from[1] == to[1]
  x = from[0]
  y = from[1]
  #if isOrtogonal
    while x!= to[0] || y!= to[1]
      set_point x,y
      (x += x <= to[0] ? +1 : -1) if x!= to[0]
      (y += y <= to[1] ? +1 : -1) if y!= to[1]
    end
    set_point *to
  #end
end
puts @points.find_all{|k,v| v > 1}.count
