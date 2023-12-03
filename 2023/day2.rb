
require "pry"                        
                                             
lines = File.open("day2.txt").read
.split("\n")   

games = lines.map.with_index do |line, index|
  title, info = line.split(":").map(&:strip)
  game = {id: index+1, sets: []}
  info.split(";")
  .map(&:strip)
  game[:sets] = info.split(";").map(&:strip)
  .map{
    Hash[*_1.split(",").map{|s| color, value = s.split(" ").reverse; [color, value.to_i]}.flatten]
  }
  #puts game 
  game
end

result1 = games.filter do |game| 
  (game[:sets].filter{ _1["red"] && _1["red"] > 12 }.size == 0) &&
  (game[:sets].filter{ _1["green"] && _1["green"] > 13 }.size == 0) &&
  (game[:sets].filter{ _1["blue"] && _1["blue"]> 14 }.size == 0)
end.sum{|g| g[:id]}

result2 = games.map do |game| 
  game[:sets].map{_1["red"]}.compact.max * game[:sets].map{_1["green"]}.compact.max * game[:sets].map{_1["blue"]}.compact.max
end.sum

puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

