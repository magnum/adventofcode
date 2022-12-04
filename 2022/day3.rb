require 'httparty'                                                                                         
require 'pry'                        



class Rucksack
  attr_accessor :str 

  def initialize(str)
    @str = str
  end

  def self.itemPriority(i)
    p = i==i.downcase ? i.ord-96 : i.ord-38
  end

  def compartment1
    @str[0..@str.length/2-1]
  end

  def compartment2
    @str[@str.length/2..]
  end

  def commonItems
    compartment1.chars & compartment2.chars
  end

  def commonItem
    commonItems.first
  end

  def commonItemPriority
    self.class.itemPriority commonItem
  end

end

                                                         
lines = File.open("day3.txt").read.split("\n")   
rucksacks = lines.map{|line| Rucksack.new(line)}                                                                      
puts "part1: #{rucksacks.map(&:commonItemPriority).inject{|sum, r| sum+=r}}"  

rucksacks_grouped = rucksacks.each_slice(3).to_a
result2 = rucksacks_grouped.map do |group|
  common_items = group.map(&:str).map(&:chars).inject{|a,e| a & e} 
  Rucksack.itemPriority(common_items.first)
end.inject{|sum, r| sum+=r}
puts "part2: #{result2}"
