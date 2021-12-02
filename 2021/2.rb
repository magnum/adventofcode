lines = open('2.txt') {|f| f.read }
.split("\n")

#part 1
h = 0
d = 0
lines.each_with_index do |line, i|
  command, x = line.split(" ")
  x = x.to_i
  case command
    when "forward"
      h += x
    when "up"
      d -= x
    when "down"
      d += x
  end
  puts "commman: #{command}, x: #{x}"
end
result = d*h
puts "h: #{h}, d: #{d}, result: #{result}"

#part 2
h = 0
d = 0
aim = 0
lines.each_with_index do |line, i|
  command, x = line.split(" ")
  x = x.to_i
  case command
    when "forward"
      h += x ; d += aim*x
    when "up"
      aim -= x
    when "down"
      aim += x
  end
  puts "commman: #{command}, x: #{x}"
end
result = d*h
puts "h: #{h}, d: #{d}, result: #{result}"
