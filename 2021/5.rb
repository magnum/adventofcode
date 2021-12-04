require 'pry'

lines = open('5.txt') {|f| f.read }
.split("\n")

lines.each_with_index do |line, i|
  puts line
end