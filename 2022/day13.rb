#part2 inspired from https://github.com/damyvv/advent-of-code-2022/blob/master/solutions/day13.rb

packets = File.read("day13.txt")
.split("\n\n")
.map {|line| line.split.map {|str| eval str.strip } }

def ordered?(a,b)
    if !a.is_a?(Array) && !b.is_a?(Array)
      a <=> b
    else
      a = [a] unless a.is_a?(Array)
      b = [b] unless b.is_a?(Array)
      a.each_with_index do |ai,i|
          break if b[i].nil?
          cmp = ordered?(ai,b[i])
          return cmp unless cmp == 0
      end
      a.length - b.length
    end
end

packet1 = [[2]]
packet2 = [[6]]
result1 = packets.map.with_index do |list,i| 
  list.sort {|a,b| ordered?(a,b) } == list ? i+1 : 0 
end.sum
puts "part1: #{result1}"
sorted = (packets << [packet1, packet2]).flatten(1).sort {|a,b| ordered?(a,b) }
result2 = (sorted.find_index(packet1)+1) * (sorted.find_index(packet2)+1)
puts "part2: #{result2}"