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
@results = []
def rulesCanContainColor?(rules, color, depth=0)
  founds = rules.select{|r| r[:contents].select{|c| c.index(color)}.length > 0}  
  puts "depth: #{depth}, searching for #{color}, found: #{founds.length}, #{founds.map{|f| f[:container]}.join(", ")}"
  @results += founds
  #binding.pry
  founds.each{|f| rulesCanContainColor?(rules, f[:container], depth+=1) } if depth < 100
end

rulesCanContainColor?(rules, "shiny gold")
puts @results.map{|r| r[:container]}.uniq.count




