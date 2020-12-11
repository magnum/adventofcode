require 'open-uri'
require 'pry'

rules = open('7.txt') {|f| f.read }
.split("\n")
.map{ |r| {
  rule: r,
  container: r.split("contain")[0].gsub(/bag(?:s)?/,"").strip,
  contents: r.split("contain")[1].split(", ").map{|r| r.gsub(/bag(?:s)?/,"").gsub(".","").strip}
}}

#pp rules
@results = 0
def addContainedBags(rules, color)
  rule = rules.find{|r| r[:container] == color}
  if rule
    rule[:contents].each do |r|
      n = r[0, r.index(" ")].to_i
      other_color = r[r.index(" "), 100].strip
      puts "n: #{n}, other_color: #{other_color}, r: #{r}"  
      n.times do |i| 
        @results +=1
        addContainedBags(rules, other_color)
      end
    end
  end
end

addContainedBags(rules, "shiny gold")
puts @results




