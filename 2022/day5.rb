
require 'pry'                        
                                             
lines = File.open('day5.txt').read.split("\n")
stacks = []
lines.each do |line|
  if line.chars.index "["
    "   #{line}".chars.each_with_index do |c, index|
      if index % 4 == 0 && c.match?(/[[:alpha:]]/)
        col = index /4
        stacks[col] = [] unless stacks[col]
        stacks[col] << c
      end
    end
    # line.chars.each_with_index do |c, index|
    #   
    # end
  end
end
stacks.compact!
stacks1 = stacks.map(&:clone)
stacks2 = stacks.map(&:clone)

def rearrange(lines)
  lines.each do |line|
    if line.chars.first == "m"
      howmany, from, to = line.scan(/\d*/).filter{|c| c!=""}.map(&:to_i)
      yield line, howmany, from, to
    end
  end
end

rearrange(lines) do |line, howmany, from, to|
  howmany.times do |i|
    stacks1[to-1].insert(0,stacks1[from-1].shift)
  end
end
puts "part1: #{stacks1.map(&:first).join("")}"

rearrange(lines) do |line, howmany, from, to|
  moving_crates = stacks2[from-1].slice!(0,howmany)
  puts "\nmoving #{moving_crates} from stack #{from} to stack #{to}"
  stacks2[to-1] = moving_crates + stacks2[to-1]
end
puts "part2: #{stacks2.map(&:first).join("")}"

