require 'open-uri'
require 'pry'


#part 1
number_buggy = nil
numbers = open('9.txt') {|f| f.read }.split("\n").map(&:to_i)
howmany = 25
numbers.each_with_index do |n, i|
  if i >= howmany #if i == 25
    previous_numbers = numbers[(i-(howmany))..(i-1)]
    number_buggy = n
    break unless previous_numbers.permutation(2).to_a.find{|c| c[0]+c[1] == n}
  end
end
puts "number_buggy: #{number_buggy}"


# part2
(2..numbers.length).each do |size|
  items = numbers.map(&:to_i)
  from = 0
  to = size-1
  while to < items.length
    block = items[from..to]
    sum = block.inject{|s,i| s+i}
    found = sum == number_buggy && block.length == size
    result = block.min+block.max
    puts "block size: #{block.size}, elements: #{block.join(", ")}, sum: #{sum} == #{number_buggy}? #{found}, result: #{result}"
    return if found
    from += 1
    to = from+size-1
  end
end