
require "pry"              

def getSymbolsAround(values, number, xlast, ylast)
  arounds = []
  ([0,ylast-1].max..[values.length,ylast+1].min).to_a.each do |y|
    arounds += values[y][[0,(xlast-number.length-1)].max..[xlast, values[y].length].min] if values[y] 
  end
  #binding.pry
  arounds.join("").gsub(number,"").split("").join("")
end

numbers = [""]                             
values = File.open("day3.txt").read
.split("\n")   
.map{ _1.split ""}

result1 = 0
values.each_with_index do |row, rindex|
  row.each_with_index do |cel, cindex|
    if cel.match?(/\d/)
      numbers[numbers.length-1] += cel  
      next
    end
    if numbers[numbers.length-1] != ""
      number = numbers[numbers.length-1]
      symbolsAround = getSymbolsAround(values, number, cindex, rindex)
      puts "found #{number}, symbolsAround: #{symbolsAround}"
      #binding.pry
      result1 += number.to_i if symbolsAround.split("").uniq.join() != "."
      numbers << "" 
    end
  end
end

result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

