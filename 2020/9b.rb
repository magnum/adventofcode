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
  for from in 0..(numbers.length-size)
    block = numbers[from..(from+size)]
    (puts "min_max_sum: #{block.min+block.max}" ; return) if block.inject{|s,i| s+i} == number_buggy
  end
end