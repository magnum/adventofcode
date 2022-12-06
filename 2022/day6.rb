
require "pry"                        
                                             
transmission = File.open("day6.txt").read

def transmissionMarkerIndex(transmission, marker_length=4)
  i=nil
  transmission.chars.each_with_index do |char, index|
    buffer = transmission[((index)-(marker_length-1))..index]
    if buffer.length == marker_length && buffer.chars.uniq.length == buffer.length
      i=index+1
      break
    end
  end
  i
end

result1 = transmissionMarkerIndex(transmission)
result2 = transmissionMarkerIndex(transmission,14)
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

