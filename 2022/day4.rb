require 'httparty'                                                                                         
require 'pry'                        
                                             
couples = File.open("input4.txt").read
.split("\n")   
.map{|r| r.split(",").map{|r| r.split("-")}.map{|r| (r[0].to_i..r[1].to_i).to_a}}
.map{|couple| couple.sort_by(&:length)}

puts "part1: #{couples.find_all{|sections| (sections[0] - sections[1]).length == 0}.length}"     
puts "part2: #{couples.find_all{|sections| (sections[0] & sections[1]).length >0}.length}"    

