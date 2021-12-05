require 'pry'

lines = open('5.test.txt') {|f| f.read }
.split("\n")

def values_between(a,b)
  b > a ? [*a..b] : [*b..a].reverse
end

points = {}
lines.each_with_index do |line, i|
  from, to = line.split("->").map(&:strip).map{|p| x,y=p.split(",").map(&:to_i)}
  isOrtogonal = from[0] == to[0] || from[1] == to[1]
  if isOrtogonal || true #&& i==0
    xvalues = values_between(from[0], to[0])
    yvalues = values_between(from[1], to[1])
    puts "from #{from}, to: #{to}, xvalues: #{xvalues}, yvalues: #{yvalues}"
    for y in yvalues
      for x in xvalues
        key = "#{x}_#{y}"  
        points[key] = points[key] ? points[key]+1 : 1 
      end
    end
    #puts "\n"
  end
end
#binding.pry
puts points.find_all{|k,v| v > 1}.count
