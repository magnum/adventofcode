require 'open-uri'
require 'pry'


#part 1
numbers = open('9.txt') {|f| f.read }.split("\n").map(&:to_i)
howmany = 25
numbers.each_with_index do |n, i|
  if i >= howmany
  #if i == 25
    previous_numbers = numbers[(i-(howmany))..(i-1)]
    #puts (i-(howmany+1)), (i-2)
    puts n
    break unless previous_numbers.permutation(2).to_a.find{|c| c[0]+c[1] == n}
  end
end

