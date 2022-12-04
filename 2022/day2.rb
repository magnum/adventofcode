require 'httparty'                                                                                         
require 'pry'                                                                                              
                                                                                                           
def calculatePoints(line)
  p1,p2 = line.gsub(" ", "").chars.sort
  points_p2 = case p2
    when "X"
      1
    when "Y"
      2
    when "Z"
      3
  end
  # my choose is the second char
  points_line = case "#{p1}#{p2}"
    when "AZ", "BX", "CY"
      0
    when "AX", "BY", "CZ"
      3
    when "AY", "BZ", "CX"
      6
  end
  points = points_p2+points_line
  puts "for line #{line} #{points_p2}+#{points_line}=#{points}"
  points                                                                                               
end                                                                                                        

def calculateLine(line)
  p1,suggestion= line.gsub(" ", "").chars.map(&:to_sym)
  p2 = case suggestion
    when :X
     {"A":"Z", "B":"X", "C":"Y"}[p1]
    when :Y
     {"A":"X", "B":"Y", "C":"Z"}[p1]
    when :Z
     {"A":"Y", "B":"Z", "C":"X"}[p1]
  end
  #binding.pry
  line= "#{p1} #{p2}"
  #puts "p1 #{p1} p2 #{p2} suggestion #{suggestion}"
  line
end
                                                                                                        
lines = File.open("day2.txt").read.split("\n")                                 
results1 = lines.map{|line| calculatePoints(line)}                                                
puts "part1: #{results1.inject{|sum, r| sum+=r}}"                                                                                 
results2 = lines.map{|line| calculatePoints(calculateLine(line))}
puts "part2: #{results2.inject{|sum, r| sum+=r}}"                   
