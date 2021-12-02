lines = open('2.test.txt') {|f| f.read }
.split("\n")
.map(&:to_i)

#part 1
lines.each_with_index do |line, i|
  puts line
end
