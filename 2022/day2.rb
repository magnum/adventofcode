require 'httparty'                                                                                         
require 'pry'                                                                                              
                                                                                                           
def calculatePoints(chooses)
  # my choose is the second char
  gamePoints = case chooses.chars.sort.join
    when "AZ", "BX", "CY"
      0
    when "AX", "BY", "CZ"
      3
    when "AY", "BZ", "CX"
      6
  end
  choosePoints = case chooses.chars.sort.last
    when "X"
      1
    when "Y"
      2
    when "Z"
      3
  end
  points = gamePoints+choosePoints
  puts "for chooses #{chooses.chars.sort.join} #{gamePoints}+#{choosePoints}=#{points}"
  points                                                                                               
end                                                                                                        
                                                                                                           
lines = File.open("input2.txt").read.split("\n")                                 
results = lines.map{|line| calculatePoints(line.gsub(" ", ""))}                                                
puts "part1: #{results.inject{|sum, r| sum+=r}}"                                                                                 
#puts "part2: #{sums.reverse.take(3).inject{|sum,i| sum+=i}}"                                               
                                                              
