
require 'pry'                        
                                             
lines = File.open('day5.txt').read.split("\n")
stacks = []
lines.each do |line|
  if line.chars.first == "["
    line = line.gsub("   ", "-")
    .gsub(" ", "")
    .gsub("[", "")
    .gsub("]", "")
    line.chars.each_with_index do |c, index|
      stacks[index] = [] unless stacks[index]
      stacks[index] << c
    end
  end
end
stacks = stacks.map{|s| s.select{|c| c != "-"}}


lines.each do |line|
  if line.chars.first == "m"
    howmany, from, to = line.scan(/\d*/).filter{|c| c!=""}.map(&:to_i)
    howmany.times do |i|
      stacks[to-1].insert(0,stacks[from-1].first)
    end
    puts "moving #{howmany} from #{from} to #{to}"
  end
end


result1 = stacks.map(&:first)
result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

